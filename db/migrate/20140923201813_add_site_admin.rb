class AddSiteAdmin < ActiveRecord::Migration
  def self.up
    puts "Creating admin user..."
    admin=User.new(first_name: 'LifeBoy', last_name: 'School', title: "Site Admin", roles_mask: 1, email: "siteadmin@lifeboy.com", password: '1234567', password_confirmation: '1234567')
    admin.save(validate: false)
  end
end
