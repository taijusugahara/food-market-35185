Corporation.find_or_create_by(id: 1) do |cor|



  cor.email = ENV['CORPORATION_EMAIL']
  cor.password = ENV['CORPORATION_PASSWORD']

end

