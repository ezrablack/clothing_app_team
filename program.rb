require_relative './config/environment.rb'

users = User.all.map {|user| user.name}
current_user = nil
item_options = Item.all.map {| item | {name: item.name, value: item}}

puts "Welcome to:"

title = Artii::Base.new(:font => 'slant') # Fonts to try: 5lineoblique, 
puts title.asciify("Phashun Werld")

prompt = TTY::Prompt.new()

# Login or Sign Up options

loop do 
    login_options = prompt.select("\nSign in or create an account:".yellow, [
        "Login",
        "Sign Up",
        "Exit",
    ])
    if(login_options == "Login")
        user_name = prompt.ask("Username:")
        heart = prompt.decorate(prompt.symbols[:heart] + ' ', :magenta)
        password = prompt.mask("Password:", symbols: {mask: heart})
        if users.include?(user_name) && User.find_by(password: password)
            current_user = User.find_by(name: user_name)
            break
        else
            puts "\nUsername or password incorrect, please try again or sign up.".red
        end
    elsif(login_options == "Sign Up")
        user_name = prompt.ask("Username:")
        if users.include?(user_name)
            puts "\nThis username already exists, please login or sign up with a new user.".red
        else
            heart = prompt.decorate(prompt.symbols[:heart] + ' ', :magenta)
            password = prompt.mask("Password", symbols: {mask: heart})
            current_user = User.create({name: user_name, password: password})
            puts "\nAcccount created successfully!\n".green
            break
        end
    elsif(login_options == "Exit")
        puts "\nTHANK ".green + "YOU ".light_blue + "FOR ".red + "VISITING ".yellow + "PHASHUN ".green + "WERLD.\n".light_blue
        exit!
    end
end

puts "\nWELCOME TO PHASHUN WELRD, WHERE WILL GETS ALL HIS COOL HATS".green
puts "WELCOME TO PHASHUN WELRD, WHERE WILL GETS ALL HIS COOL HATS".blue
puts "WELCOME TO PHASHUN WELRD, WHERE WILL GETS ALL HIS COOL HATS".red
puts "WELCOME TO PHASHUN WELRD, WHERE WILL GETS ALL HIS COOL HATS".yellow
puts "WELCOME TO PHASHUN WELRD, WHERE WILL GETS ALL HIS COOL HATS".green
puts "WELCOME TO PHASHUN WELRD, WHERE WILL GETS ALL HIS COOL HATS".blue
puts "WELCOME TO PHASHUN WELRD, WHERE WILL GETS ALL HIS COOL HATS".red
puts "WELCOME TO PHASHUN WELRD, WHERE WILL GETS ALL HIS COOL HATS\n".yellow

# User's options
loop do
    user_choice = prompt.select('MAIN MENU'.light_blue, [
        "Browse Items",
        "View my Cart",
        "Checkout",
        "Logout"
    ])

    # Browse available items
    if(user_choice == "Browse Items")
        selected_item = prompt.select('Choose an Item:', item_options)
        if selected_item.stock == 0
            puts "\n#{selected_item.name} is currently out of stock.\n".red
        else
            Purchase.create(item_id: selected_item.id, user_id: current_user.id, item_name: selected_item.name, total_price: selected_item.price)
            selected_item.stock -= 1
            selected_item.save
        end
        cart = Purchase.all.where(user_id: current_user.id)
    end

    # View current items in cart
    if(user_choice == "View my Cart")
        cart = Purchase.all.where(user_id: current_user.id)
        if cart.length > 0
            cart.each do | purchase |
                puts "Item: #{purchase.item_name}, Price: #{purchase.total_price}"
            end
        else
            puts "\nYou have not added any items to your cart yet.".red # offer a coupon code here in the future
            puts "If you're hesitant to purchase an item, use coupon code " + "'CODE10' ".green + "for 10% off at checkout.\n\n"
        end
        
        # Remove item from cart functionality 
        loop do 
            view_cart = cart.all.map {|item| item.item_name}
            cart_choices = prompt.select("\nCART OPTIONS".light_blue, [
                "Remove an Item",
                "Main Menu"
            ]) 
            if(cart_choices == "Remove an Item")
                item_to_delete = prompt.select("Which item would you like to remove?".light_blue, view_cart) 
                restock_item = Item.find_by(name: item_to_delete)
                restock_item.stock += 1 
                restock_item.save
                cart.find_by(item_name: item_to_delete).destroy
                cart = Purchase.all.where(user_id: current_user.id)
                puts cart.all.map {|item| item.item_name}
            end
            if(cart_choices == "Main Menu")
                break
            end  
        end  
    end

    # Checkout functionality
    if(user_choice == "Checkout")
        cart_total = 0
        current_user.purchases.each do | purchase |
            cart_total += purchase.total_price
        end
        puts cart_total

        # Apply a discount
        discount_code = prompt.yes?("\nDo you have a discount code?\n".yellow)
        if discount_code == true
            has_code = prompt.ask("Please enter your discount code: ".yellow)
            code = Discount.find_by({ name: has_code })
            if has_code == code.name
                discount_value = (code.value.to_f * 0.01) * cart_total
                new_cart_total = cart_total - discount_value
                puts "\nDiscount Applied\n".green
                puts "Total is #{new_cart_total.round(2)}"
            else 
                puts "\nCode is incorrect, please try again.\n".red
            end
        else 
            puts "Your total is ".green + "#{cart_total}"
        end 
    end

    if(user_choice == "Logout")
        puts "\nTHANK ".green + "YOU ".light_blue + "FOR ".red + "VISITING ".yellow + "PHASHUN ".green + "WERLD.\n".light_blue
        exit!
    end
end 