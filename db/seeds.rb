# I expect that we have portal to create clients then share the id and secrets to generate the access token
client = Client.find_by(id: "cd2fe9e2-7e2c-4e91-9c43-fb8a423764da")

unless client
  client = Client.create(id: "cd2fe9e2-7e2c-4e91-9c43-fb8a423764da" ,name: 'client A', secret: "a0TLqAYlW0pXMG38qZKcUg==")
end

puts "********************************"
puts "*                              "
puts "*        #{client.id}          "
puts "*        #{client.secret}      "
puts "*                              "
puts "********************************"

