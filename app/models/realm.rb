require File.dirname(__FILE__) + "/../../config/wow_achievement_connection.rb"

class Realm < WowAchievementConnection
  def self.searchForRealm(realm)
    @realm = Realm.find(:all,
        :conditions => "realm_name = '#{realm}'")

    return @realm
  end
end
