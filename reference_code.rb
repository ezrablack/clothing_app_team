require_relative './config/environment.rb'
puts "Welcome To:"

a = Artii::Base.new(:font => 'slant')
puts a.asciify("Fly Abroad")

prompt = TTY::Prompt.new()

user_choice = prompt.select('What do you want to do?', [
    "Purchase a Ticket",
    "See my Tickets"
])

if(user_choice == "See my Tickets")
    user_name = prompt.ask("What's Your Name?")

    existing_passengers = Passenger.where({ name: user_name })
    if existing_passengers.length == 0
        current_passenger = Passenger.create({ name: user_name })
    else
        current_passenger = existing_passengers[0]
    end

    current_passenger.tickets.each do | ticket |
        puts "#{ticket.number}: #{ticket.departure_city}-#{ticket.destination_city} ($#{ticket.price})"
    end

end
if(user_choice == "Purchase a Ticket")

    airline_options = Airline.all.map do | airline |
        {
            name: airline.name, # <-- User sees this
            value: airline # <-- But we get back this
        }
    end

    selected_airline = prompt.select('Choose an Airline:', airline_options)

    available_tickets = selected_airline.tickets.where({ passenger_id: nil })

    ticket_options = available_tickets.map do | ticket |
        {
            name: "#{ticket.number}: #{ticket.departure_city}-#{ticket.destination_city} ($#{ticket.price})",
            value: ticket
        }
    end

    if ticket_options.length == 0
        puts "No Tickets Available"
        return
    end

    selected_ticket = prompt.select('Choose a Ticket to Purchase:', ticket_options)

    user_name = prompt.ask("What's Your Name?")

    existing_passengers = Passenger.where({ name: user_name })
    if existing_passengers.length == 0
        current_passenger = Passenger.create({ name: user_name })
    else
        current_passenger = existing_passengers[0]
    end

    selected_ticket.passenger_id = current_passenger.id # 2

    selected_ticket.save()
