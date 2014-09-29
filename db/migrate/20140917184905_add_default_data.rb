class AddDefaultData < ActiveRecord::Migration
  def self.up
    puts "Creating Agency..."
    Agency.create([{name: 'Market Access Providers Ltd'}, {name: 'Searchlite Communications Ltd'}, {name: 'Asiatic Event Marketing Ltd'}, {name: 'Interspeed Activation Ltd'}])
  end
end
