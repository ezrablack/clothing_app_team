require_relative './config/environment.rb'

users = User.all.map {|user| user.name}
current_user = nil
item_options = Item.all.map {| item | {name: item.name, value: item}}

puts "Welcome to:"

title = Artii::Base.new(:font => 'slant')
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
        if users.include?(user_name)
            current_user = User.find_by(name: user_name)
            break
        else
            puts "This username does not exist, please try again or sign up."
        end
    elsif(login_options == "Sign Up")
        user_name = prompt.ask("Username:")
        if users.include?(user_name)
            puts "This username already exists, please login or sign up with a new user"
        else
            current_user = User.create({name: user_name})
            break
        end
    end
end

# User's options
loop do
    user_choice = prompt.select('What do you want to do?', [
        "Purchase an Item",
        "See my Purchases"
    ])

    if(user_choice == "Purchase an Item")
        selected_item = prompt.select('Choose an Item:', item_options)

        Purchase.create(item_id: selected_item.id, user_id: current_user.id, item_name: selected_item.name, total_price: selected_item.price)

    end

    if(user_choice == "See my Purchases")
        if current_user.purchases.length > 0
            current_user.purchases.each do | purchase |
                puts "Item: #{purchase.item_name}, Price: #{purchase.total_price}"
            end
        else
            puts "You have not made any purchases yet." # offer a coupon code here in the future
        end 
    end

        # ^^ Use line 52-59 when we add stock to items

end 