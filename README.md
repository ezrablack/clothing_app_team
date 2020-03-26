# Item -< Purchases >- User

# User Stories: 
    DONE* User will be able to browse clothing store for clothing
    DONE* User can purchase item(s) of clothing

# MVP:
    DONE* Should be able to see available clothing items
    DONE* User should have cart with total items and total ticket
    DONE* Clothing store should update stock if user selects a piece 
    
# Stretch Goals:
    * Items have/display multiple sizes and colors
    * User can search clothing items by color
    * User can search by size
    * User can search by price
    * Add quantity(qty) option where User can purchase multiple of same item
    * Payment method after checkout
    * Exit message that ends the program
    DONE* User can enter a discount code at purchase
    DONE* Build more models once base is working
    DONE** Multiple purchases through multiple users 
    DONE** User Login
    DONE*** User can return and item of clothing
    

# Clothing Item Properties: (has a purchase, has a user through a purchase)
    DONE* name
    DONE* cost
    DONE** size
    DONE** stock
    
<!-- # Purhcase(Cart) (belongs to store and user)
    * has user/item id([4, 5, 6])
    * contains items from store belong to user
    * total items
    * total cost -->

# Purchase (belongs to store and user)
    DONE* has user/store id 
    DONE* contains items from store belong to user

# User Properties: (has many purchases, has many clothing items through purchases)
    DONE* username  

<!-- # Clothing Properties: (belongs to store and user)
    * brand name
    * item category
    * item name
    * item size
    * item price -->

Stretch method example:

        # available_items = selected_item.tickets.where({ passenger_id: nil })

        # ticket_options = available_tickets.map do | ticket |
        #     {
        #         name: "#{ticket.number}: #{ticket.departure_city}-#{ticket.destination_city} ($#{ticket.price})",
        #         value: ticket
        #     }
        # end

        # ^^ Use line 52-59 when we add stock to items
