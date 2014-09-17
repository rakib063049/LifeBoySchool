class AddDefaultData < ActiveRecord::Migration
  def self.up
    puts "Creating Division..."
    dhaka_div = Division.create(name: "Dhaka")
    Division.create([{name: "Chittagong"}, {name: "Sylhet"}, {name: "Rajshahi"}, {name: "Rangpur"}, {name: "Khulna"}, {name: "Barisal"}])

    puts "Creating District..."
    tangail_dist = District.create(name: "Tangail", division_id: dhaka_div.id)

    puts "Creating Thana..."
    nagorpur_thana = Thana.create(name: "Nagorpur", district_id: tangail_dist.id)

    puts "Creating Union..."
    Union.create(name: "Shajani", thana_id: nagorpur_thana.id)

    puts "Creating Agency..."
    Agency.create([{name: 'Market Access Providers Ltd'}, {name: 'Searchlite Communications Ltd'}, {name: 'Asiatic Event Marketing Ltd'}, {name: 'Interspeed Activation Ltd'}])
  end
end
