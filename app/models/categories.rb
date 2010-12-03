require File.dirname(__FILE__) + "/../../config/wow_achievement_connection.rb"

class Categories < WowAchievementConnection

  def self.find_categories_by_type(categoryTypeID)
    @categories = self.find(:all, :order => "id",
          :conditions => "category_type_id = #{categoryTypeID}")

    return @categories
  end

end