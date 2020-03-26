def login
    users = User.all.map {|user| user.name}
    loop do 
        login_options = $prompt.select("\nSign in or create an account:".yellow, [
            "Login",
            "Sign Up",
            "Exit",
        ])
        if(login_options == "Login")
            user_name = $prompt.ask("Username:")
            heart = $prompt.decorate($prompt.symbols[:heart] + ' ', :magenta)
            password = $prompt.mask("Password:", symbols: {mask: heart})
            if users.include?(user_name) && User.find_by(password: password)
                $current_user = User.find_by(name: user_name)
                welcome
                shop
                break
            else
                puts "\nUsername or password incorrect, please try again or sign up.".red
            end
        elsif(login_options == "Sign Up")
            user_name = $prompt.ask("Username:")
            if users.include?(user_name)
                puts "\nThis username already exists, please login or sign up with a new user.".red
            else
                heart = $prompt.decorate($prompt.symbols[:heart] + ' ', :magenta)
                password = $prompt.mask("Password", symbols: {mask: heart})
                $current_user = User.create({name: user_name, password: password})
                puts "\nAcccount created successfully!\n".green
                welcome
                shop
                break
            end
        elsif(login_options == "Exit")
            puts "\nTHANK ".green + "YOU ".light_blue + "FOR ".red + "VISITING ".yellow + "PHASHUN ".green + "WERLD.\n".light_blue
            exit!
        end
    end
end 

def welcome
    puts "\nWELCOME TO PHASHUN WELRD, WHERE WILL GETS ALL HIS COOL HATS".green
    puts "WELCOME TO PHASHUN WELRD, WHERE WILL GETS ALL HIS COOL HATS".blue
    puts "WELCOME TO PHASHUN WELRD, WHERE WILL GETS ALL HIS COOL HATS".red
    puts "WELCOME TO PHASHUN WELRD, WHERE WILL GETS ALL HIS COOL HATS".yellow
    puts "WELCOME TO PHASHUN WELRD, WHERE WILL GETS ALL HIS COOL HATS".green
    puts "WELCOME TO PHASHUN WELRD, WHERE WILL GETS ALL HIS COOL HATS".blue
    puts "WELCOME TO PHASHUN WELRD, WHERE WILL GETS ALL HIS COOL HATS".red
    puts "WELCOME TO PHASHUN WELRD, WHERE WILL GETS ALL HIS COOL HATS\n".yellow
end