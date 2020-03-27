def shop
    loop do
        user_choice = $prompt.select('MAIN MENU'.light_blue, [
            "Browse Items",
            "View my Cart",
            "Checkout",
            "Logout"
        ])
    
        # Browse available items
        if(user_choice == "Browse Items")
            selected_item = $prompt.select('Choose an Item:', $item_options)
            cart = $current_user.add_to_cart(selected_item)
        end
    
        # View current items in cart
        if(user_choice == "View my Cart")
            cart = CartItem.all.where(user_id: $current_user.id)
            if cart.length > 0
                cart.each do | cart_item |
                    puts "\nItem: #{cart_item.item_name}, Price: #{cart_item.total_price}"
                end
            puts "\n"
            else
                puts "\nYou have not added any items to your cart yet.".red # offer a coupon code here in the future
                puts "If you're hesitant to purchase an item, use coupon code " + "'CODE10' ".green + "for 10% off at checkout.\n\n"
            end
            
            # Remove item from cart functionality 
            loop do 
                view_cart = cart.all.map {|item| item.item_name}
                cart_choices = $prompt.select("\nCART OPTIONS".light_blue, [
                    "Remove an Item",
                    "Main Menu"
                ]) 
                if(cart_choices == "Remove an Item")
                    item_to_delete = $prompt.select("Which item would you like to remove?".light_blue, view_cart) 
                    cart = $current_user.remove_from_cart(item_to_delete)
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
            $current_user.cart_items.each do | cart_item |
                cart_total += cart_item.total_price
            end
            puts "\nYour total is ".green + "#{cart_total}"
    
            # Apply a discount
            discount_code = $prompt.yes?("\nDo you have a discount code?\n".yellow)
            if discount_code == true
                has_code = $prompt.ask("Please enter your discount code: ".yellow)
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

            payment_options = $prompt.select("Options", [
                "Pay Now",
                "Continue Shopping"
            ])

            if (payment_options == "Pay Now")
                puts "\nPayment Successful".green
                puts "Your order # is #{rand(10000..19999)}\n\n"
                $current_user.cart_items.destroy(CartItem.all.where(user_id: $current_user.id))
            end

            if (payment_options == "Continue Shopping")
                next
            end
        end
    
        if(user_choice == "Logout")
            puts "\nTHANK ".green + "YOU ".light_blue + "FOR ".red + "VISITING ".yellow + "PHASHUN ".green + "WERLD.\n".light_blue
            exit!
        end
    end
end  