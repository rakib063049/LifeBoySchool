json.array!(@visits) do |visit|
  json.extract! visit, :id, :quarter, :visited_at, :created_by
  json.url visit_url(visit, format: :json)
end
