describe(User) do 

    before do
        @user = User.new("John", "123")
    end
    
    # user can login
    # login fails if a user enters incorrect password
    # user can signup
    # username must be unique
    # user can browse items
    # user can view cart
    # user can checkout

end

# it("has a class method to log an owner in") do
#     Owner.login('Angelo')
#     owner = Owner.find_by({ name: 'Angelo' })
#     expect(owner.name).to(eq('Angelo'))
# end

# it("has a save_dog method") do 
#     angelo = Owner.login('Angelo')
#     angelo.save_dog("Tilly")
#     dog = Dog.find_by({ name: 'Tilly'})
#     expect(dog.name).to(eq('Tilly'))
#     expect(dog.owner).to(eq(angelo))
# end