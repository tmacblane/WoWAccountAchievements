require 'rubygems'
require 'nokogiri'
require 'open-uri'

class SetRealms < ActiveRecord::Migration
  def self.up
    us_realm_list = Nokogiri::HTML(open("http://forums.worldofwarcraft.com/child-forum.html?forumId=11119&sid=1"))
    us_realm_list.xpath("//tr/td/span/ul[@id='rlist']/li/a").each do |realm|
      Realm.create(:realm_local => "US", :realm_name => realm.inner_html)
    end
  end

  def self.down
  end
end