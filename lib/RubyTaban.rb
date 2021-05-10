require 'ruby_figlet'
require 'colorize'
require 'uri'
require 'net/http'
require 'json'
using RubyFiglet

class RubyTaban
  attr_accessor :banner,:girinti

  def initialize(banner, girinti = 1)
    @banner  = banner
    @girinti = girinti
    logo_yazdir()
    bilgi_yazdir()
  end

  def logo_yazdir()
    temizle()
    puts ((" " * @girinti).to_s + @banner + "\n\n").art!.green
    puts "\n\n"
  end

  def bilgi_yazdir()
    time = Time.new

    oturum = (ENV['USERNAME'].to_s + "@" + ENV["COMPUTERNAME"].to_s).cyan.center(44)
    ip     = global_ip().yellow.center(44)
    cihaz  = ENV["OS"].red.center(44)
    zaman  = ((time.strftime("%d-%m-%Y")).to_s + " | " + (time.strftime("%k:%M")).to_s).center(30)
    
    bilgi  = "\t\t#{cihaz}\n\t\t#{zaman.yellow}\n\n\t\t#{oturum}\n\t\t#{ip}"
    puts bilgi
    puts "\n"
  end

  def log_salla(sol, orta, sag)
    zaman = Time.new.strftime("%k:%M:%S")
    if zaman[" "]
      zaman[" "] = "0"
    end
    if (!sol.is_a?(String) || !orta.is_a?(String) || !sag.is_a?(String))
      bicimlendir = "[#{zaman}]".cyan + " Sadece String Değere izin verilir".yellow
      puts bicimlendir
      return
    end

    sol1  = "#{sol[0,12]}".red + ("~".cyan if sol.length > 13).to_s
    orta1 = "#{orta[0,18]}".yellow + ("~".cyan if orta.length > 19).to_s
    sag1  = "#{sag[0,13]}".magenta + ("~".cyan if sag.length  > 14).to_s
    
    
    bicimlendir = "[#{zaman}]".cyan + " #{sol1}" + (" " * (15 - sol[0,13].to_s.length)).to_s + "||".green + " #{orta1} " + (" " * (21 - orta[0,19].to_s.length)).to_s + "||".green + " #{sag1}"
    puts bicimlendir
  end

  def hata_salla(hata)
    zaman = Time.new.strftime("%k:%M:%S")
    zaman[" "] = "0"

    bicimlendir = "[#{zaman}]".cyan + " #{hata.class.name}".yellow + "  || ".magenta + "#{hata.message}"
    puts bicimlendir
  end

  def temizle()
    Gem.win_platform? ? (system "cls") : (system "clear")
  end

  def global_ip()
    begin
      uri = URI("http://ip-api.com/json")
      res = Net::HTTP.get_response(uri)
      if res.is_a?(Net::HTTPSuccess)
        return JSON.parse(res.body)["query"]
      else
        uri = URI("https://api.ipify.org")
        res = Net::HTTP.get_response(uri)
        if res.is_a?(Net::HTTPSuccess)
          return res.body
        else
          return "127.0.0.1"
        end
      end
    rescue Errno::ECONNREFUSED
      uri = URI("https://api.ipify.org")
      res = Net::HTTP.get_response(uri)
      if res.is_a?(Net::HTTPSuccess)
        return res.body
      else
        return "127.0.0.1"
      end
    end
  end

end