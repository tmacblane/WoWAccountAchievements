require File.dirname(__FILE__) + "/../../config/wow_achievement_connection.rb"
require "realm.rb"

class Character < WowAchievementConnection

  def self.search_for_character_by_realm(character, realm)
    @realm = Realm.search_for_realm(realm)

    @character = Character.find(:all,
        :conditions => "character_name = '#{character}' AND realm_id = '#{@realm[0].id}'")

    return @character
  end

  def self.add_character(character, realm)
    @realm = Realm.search_for_realm(realm)
    
    Character.create(:character_name => character,
                       :realm_id => @realm[0])

    @character = search_for_character_by_realm(character, realm)
    return @character
  end

end
