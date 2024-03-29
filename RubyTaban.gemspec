Gem::Specification.new do |s|
  s.name        = 'RubyTaban'
  s.version     = '0.0.3'
  s.summary     = "Ruby için Konsol Tabanı (Kararlı Sürüm)"
  s.description = "Ruby'de konsolunuz güzel bi biçime sokan kütüphane"
  s.authors     = ["Ömer Faruk Biçer"]
  s.email       = 'omerfarukbicer0446@gmail.com'
  s.files       = ["lib/RubyTaban.rb"]
  s.homepage    =
    'https://github.com/ofarukbicer/RubyTaban'
  s.license       = 'MIT'

  s.add_dependency 'ruby_figlet', '~> 0.6.1'
  s.add_dependency 'colorize', '~> 0.8.1'
end
