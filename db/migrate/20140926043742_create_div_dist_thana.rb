class CreateDivDistThana < ActiveRecord::Migration
  def self.up
    puts "Creating Divisions......"
    Division.destroy_all
    CSV.foreach(Rails.root.join("divdisthana.csv"), headers: true) do |row|
      Division.create!(name: row[0]) if Division.where(name: row[0]).size == 0
    end

    puts "Creating District......"
    District.destroy_all
    CSV.foreach(Rails.root.join("divdisthana.csv"), headers: true) do |row|
      division = Division.where(name: row[0]).first
      District.create!(name: row[1], division_id: division.id) if District.where(name: row[1]).size == 0
    end

    puts "Creating Thana......"
    Thana.destroy_all
    CSV.foreach(Rails.root.join("divdisthana.csv"), headers: true) do |row|
      district = District.where(name: row[1]).first
      Thana.create!(name: row[2], code: row[3], district_id: district.id) if Thana.where(name: row[2]).size == 0
    end
  end
end
