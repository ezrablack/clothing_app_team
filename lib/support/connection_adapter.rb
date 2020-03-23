class ConnectionAdapter 
    attr_reader :adapter, :database

    def intialize(database, adapter = "sqlite3")
        @database = database
        @adapter = adapter
    end

    def connect!
        ActiveRecord::Base.establish_connection(
            :adapter => self.adapter, 
            :database => self.database
        )
    end 

end 