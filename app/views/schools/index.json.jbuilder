json.array!(@schools) do |school|
  json.extract! school, :id, :year, :unique_id, :agency_id, :country, :division_id, :district_id, :thana_id, :union_id, :title, :headmaster_name, :phone, :boyes, :girls, :created_by
  json.url school_url(school, format: :json)
end
