Corporation.find_or_create_by(id: 1) do |cor|
  cor.email = 'corporation@1.com'
  cor.password = 'corporation'
end