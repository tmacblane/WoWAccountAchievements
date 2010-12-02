require "rubygems"
require "selenium"
require "selenium/client"

class WebBrowser
  attr_accessor :selenium
  
	def initialize
		@selenium = Selenium::Client::Driver.new("localhost", 4444, "*firefox", "http://www.wowarmory.com/character-achievements.xml?r=Illidan&n=Mosch", 20)

    sleep(1)
		start
		open("/")
	end

	def start
		@selenium.start
		@selenium.set_speed(0)
    @selenium.window_maximize()
	end

	def close
		@selenium.close
	end

	def stop
    close
		@selenium.stop
	end

	def open(site)
		@selenium.open(site)
	end  
end
