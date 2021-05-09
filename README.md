```rb
require "RubyTaban"

taban = RubyTaban.new(
  banner  = "RubyTaban",
  girinti = 1
)

taban.log_salla(12346465465465465465, "asdasdasdasdasdasdasd", "ASDSDasdasdasdasdasd")
sleep(1)
taban.log_salla("12346465465465465465", "sadasd", "ASDSDasdasdasdasdasd")
sleep(1)

begin
  bakalim()
rescue => hata
  taban.hata_salla(hata)
end
```