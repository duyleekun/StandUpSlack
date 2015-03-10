json.array!(@tasks) do |task|
  json.extract! task, :id, :description, :username, :type
  json.url task_url(task, format: :json)
end
