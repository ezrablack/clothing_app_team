require_relative './config/environment.rb'

puts "Welcome to:"

a = Artii::Base.new(:font => 'slant')
puts a.asciify("Phashun Werld")

prompt = TTY::Prompt.new()

loop do 

    user_choice = prompt.select('What do you want to do?', [
        "Purchase an Item",
        "See my Purchases"
    ])

    if(user_choice == "See my Purchases")
        user_name = prompt.ask("What's Your Name?")
    
        users = User.where({ name: user_name })
        if users.length == 0
            current_user = User.create({ name: user_name })
            puts "#{current_user}, you have not made any purchases yet." # offer a coupon code here in the future
        else
            current_user = users[0]
            current_user.purchases.each do | purchase |
                puts "Item: #{purchase.item_name}, Price: #{purchase.total_price}"
            end
        end
    end

    if(user_choice == "Purchase an Item")

        # all_items = Item.all.map do | item |
        #     {
        #         name: item.name, # <-- User sees this
        #         value: item # <-- But we get back this
        #     }
        # end

        item_options = Item.all.map do | item |
            {
                name: item.name, # <-- User sees this
                value: item # <-- But we get back this
            }
        end
        
        selected_item = prompt.select('Choose an Item:', item_options)

        user_name = prompt.ask("What's Your Name?")

        users = User.where({ name: user_name })
        if users.length == 0
            current_user = User.create({ name: user_name })
        else
            current_user = users[0]
        end

        Purchase.create(item_id: selected_item.id, user_id: current_user.id, item_name: selected_item.name, total_price: selected_item.price) # 2
        
    
        # selected_ticket.update({ passenger_id: current_user.id }) # <- This works to

        # available_items = selected_item.tickets.where({ passenger_id: nil })

        # ticket_options = available_tickets.map do | ticket |
        #     {
        #         name: "#{ticket.number}: #{ticket.departure_city}-#{ticket.destination_city} ($#{ticket.price})",
        #         value: ticket
        #     }
        # end

        # ^^ Use line 52-59 when we add stock to items


    end
end 