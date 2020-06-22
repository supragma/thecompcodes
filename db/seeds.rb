requests = [ "test req1" ]
requests.each do |name|
  Request.create(name: name)
end