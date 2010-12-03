require File.dirname(__FILE__) + "/../../config/wow_achievement_connection.rb"

class Realm < WowAchievementConnection
  def self.search_for_realm(realm)
    @realm = Realm.find(:all,
        :conditions => "realm_name = '#{realm}'")

    return @realm
  end
end
