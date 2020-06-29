begin
  HomePage.first_or_create(name: 'Somos una agencia de desarrollo digital')
rescue
  nil
end
