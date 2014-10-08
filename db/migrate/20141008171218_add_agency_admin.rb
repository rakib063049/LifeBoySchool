class AddAgencyAdmin < ActiveRecord::Migration
  def self.up
    Agency.create(name: 'Admin', code: 'admin')
  end
end
