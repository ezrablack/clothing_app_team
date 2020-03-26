require_relative './config/environment.rb'

$current_user = nil
$item_options = Item.all.map {| item | {name: item.name, value: item}}

puts "Welcome to:"

title = Artii::Base.new(:font => 'slant') # Fonts to try: 5lineoblique, 
puts title.asciify("Phashun Werld")

$prompt = TTY::Prompt.new()

# Login or Sign Up options

login # login function inside of login.rb