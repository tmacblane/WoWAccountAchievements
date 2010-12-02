require File.dirname(__FILE__) + "/../../config/wow_achievement_connection.rb"
require "realm.rb"

class Character < WowAchievementConnection

  def self.searchForCharacterByRealm(character, realm)
    @realm = Realm.searchForRealm(realm)

    @character = Character.find(:all,
        :conditions => "character_name = '#{character}' AND realm_id = '#{@realm[0].id}'")

    return @character
  end

  def self.addCharacter(character, realm)
    @realm = Realm.searchForRealm(realm)
    
    Character.create(:character_name => character,
                       :realm_id => @realm[0])
  end

end
