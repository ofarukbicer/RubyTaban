require 'ruby_figlet'
require 'colorize'
require 'uri'
require 'net/http'
require 'json'
using RubyFiglet

class RubyTaban
  attr_accessor :banner,:tabs

  def initialize(banner, tabs = 1)
    @banner  = banner
    @tabs = tabs
    logo
    information
  end

  def logo
    clear
    puts ((" " * @tabs).to_s + @banner + "\n\n").art!.green
    puts "\n\n"
  end

  def information
    time = Time.new

    session       = (ENV['USERNAME'].to_s + "@" + ENV["COMPUTERNAME"].to_s).cyan.center(44)
    ip           = global_ip.yellow.center(44)
    pc           = ENV["OS"].red.center(44)
    time_format  = ((time.strftime("%d-%m-%Y")).to_s + " | " + (time.strftime("%k:%M")).to_s).center(30)
    
    information_text  = "\t\t#{pc}\n\t\t#{time_format.yellow}\n\n\t\t#{session}\n\t\t#{ip}"
    puts information_text
    puts "\n"
  end

  def log(left, center, right)
    time = Time.new.strftime("%k:%M:%S")
    if time[" "]
      time[" "] = "0"
    end
    if (!left.is_a?(String) || !center.is_a?(String) || !right.is_a?(String))
      format_text = "[#{time}]".cyan + " Sadece String Değere izin verilir".yellow
      puts format_text
      return
    end

    left1  = "#{left[0,12]}".red + ("~".cyan if left.length > 13).to_s
    center1 = "#{center[0,18]}".yellow + ("~".cyan if center.length > 19).to_s
    right1  = "#{right[0,13]}".magenta + ("~".cyan if right.length  > 14).to_s
    
    
    format_text = "[#{time}]".cyan + " #{left1}" + (" " * (15 - left[0,13].to_s.length)).to_s + "||".green + " #{center1} " + (" " * (21 - center[0,19].to_s.length)).to_s + "||".green + " #{right1}"
    puts format_text
  end

  def error(exception)
    time = Time.new.strftime("%k:%M:%S")
    if time[" "]
      time[" "] = "0"
    end

    format_text = "[#{time}]".cyan + " #{exception.class.name}".yellow + "  || ".magenta + "#{exception.message}"
    puts format_text
  end

  def clear
    Gem.win_platform? ? (system "cls") : (system "clear")
  end

  def global_ip
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