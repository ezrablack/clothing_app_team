User.destroy_all
Item.destroy_all
Discount.destroy_all
CartItem.destroy_all

d_angelo = User.create(name: "D'Angelo", password: "123")
chris = User.create(name: "Chris Angel", password: "123")

fancy_pants = Item.create(name: "Fancy Pants", price: 150.00, stock: 10)
fancy_shirt = Item.create(name: "Fancy Shirt", price: 75.49, stock: 0)
shoe = Item.create(name: "Shoes", price: 50.50, stock: 10)
fancy_underpants = Item.create(name: "Fancy Underpants", price: 30.32, stock: 0)
business_socks = Item.create(name: "Business Socks", price: 25.75, stock: 10)
fedora = Item.create(name: "M'Lady Fedora", price: 30.01, stock: 10)

code10 = Discount.create(name: "CODE10", value: 10)
code20 = Discount.create(name: "CODE20", value: 20)
code25 = Discount.create(name: "CODE25", value: 25)