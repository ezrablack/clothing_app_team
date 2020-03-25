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
    login_options = prompt.select('Sign in or create an account', [
        "Login",
        "Sign Up"
    ])
    if(login_options == "Login")
        user_name = prompt.ask("Username:")
        heart = prompt.decorate(prompt.symbols[:heart] + ' ', :magenta)
        password = prompt.mask("Password:", symbols: {mask: heart})
        if users.include?(user_name) && User.find_by(password: password)
            current_user = User.find_by(name: user_name)
            break
        else
            puts "Username or password incorrect, please try again or sign up."
        end
    elsif(login_options == "Sign Up")
        user_name = prompt.ask("Username:")
        if users.include?(user_name)
            puts "This username already exists, please login or sign up with a new user"
        else
            heart = prompt.decorate(prompt.symbols[:heart] + ' ', :magenta)
            password = prompt.mask("Password", symbols: {mask: heart})
            current_user = User.create({name: user_name, password: password})
            break
        end
    end
end

# User's options
loop do
    user_choice = prompt.select('What do you want to do?', [
        "Browse Items",
        "View my Cart",
        "Checkout"
    ])

    if(user_choice == "Browse Items")
        selected_item = prompt.select('Choose an Item:', item_options)

        Purchase.create(item_id: selected_item.id, user_id: current_user.id, item_name: selected_item.name, total_price: selected_item.price)
    end

    if(user_choice == "View my Cart")
        if current_user.purchases.length > 0
            current_user.purchases.each do | purchase |
                puts "Item: #{purchase.item_name}, Price: #{purchase.total_price}"
            end
        else
            puts "You have not made any purchases yet." # offer a coupon code here in the future
        end 
    end

    if(user_choice == "Checkout")
        cart_total = 0
        current_user.purchases.each do | purchase |
            cart_total += purchase.total_price
        end
        puts cart_total
        discount_code = prompt.yes?("Do you have a discount code? ")
        if discount_code == true
            has_code = prompt.ask("Please enter your discount code: ")
            code = Discount.where(name: has_code)
            puts code
            if has_code == code[0]
                valid_code = code[0]
                discount_value = valid_code.value * 0.01
                new_cart_total = cart_total - discount_value
                puts "Discount Applied"
                puts new_cart_total
            else 
                puts "Code is incorrect, please try again."
            end
        else 
            puts "Total is #{cart_total}"
        end 
    end
    
    
    
end 
# def apply_discount
#     if self.discount > 0
#         self.discount = (self.discount.to_f * 0.01) * self.total
#         self.total = (self.total - self.discount).to_i
#         return "After the discount, the total comes to $800."
#     else
#         return "There is no discount to apply."
#     end
# end