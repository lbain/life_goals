json.array!(@goals) do |goal|
  json.extract! goal, :title, :due_date, :repeat
  json.url goal_url(goal, format: :json)
end