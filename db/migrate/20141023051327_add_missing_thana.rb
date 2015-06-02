class AddMissingThana < ActiveRecord::Migration
  def self.up
    puts "Creating Thana......"
    CSV.foreach(Rails.root.join("missingthana.csv"), headers: true) do |row|
      district = District.where(name: row[1]).first
      Thana.create!(name: row[2], code: row[3], district_id: district.id) if Thana.where(name: row[2], district_id: district.id).size == 0
    end
  end
end
