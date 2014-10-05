class AddAgencyCodeStringToAgency < ActiveRecord::Migration
  def self.up
    Agency.all.each do |agency|
      code = agency.name[0, 1]
      agency.update_attributes(code: code)
    end
  end

  def self.down
  end
end
