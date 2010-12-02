require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'achievement.rb'
require 'categories.rb'
require 'character.rb'
require 'realm.rb'
require 'character_achievement.rb'

class GetAchieves

  def self.armoryURL(character, realm, categoryID)
    "http://www.wowarmory.com/character-achievements.xml?r=#{realm}&n=#{character}&c=#{categoryID}"
  end

  def self.getAchievesByCharacterName(character, realm)
    
    @character = Character.searchForCharacterByRealm(character, realm) #search for character by realm

    if @character.to_s == ""
      Character.addCharacter(character, realm) #if character does not exist, add to database
    end
    
    @character = Character.searchForCharacterByRealm(character, realm) #set character constant to newly added character

    @categories = Categories.findCategoriesByType(0)  #finds all categories of type 0 (achievements)
    @categories.each do |category|    #Loop through each root category id
      characterAchievementFrame = Nokogiri::HTML(open(armoryURL(character, realm, category.category_id)))

      #Do for Completed Achieves
      characterAchievementFrame.xpath("//div/div/div[starts-with(@id, 'ach')][@class='achievement']").each do |achieveID|
        if (characterAchievementFrame.xpath("//div/div/div[@id='#{achieveID['id']}']/ul[@class='criteria c_list']/li[starts-with(@id, 'ach')][@class='c_list_col criteriamet']")) != ""
          characterAchievementFrame.xpath("//div/div/div[@id='#{achieveID['id']}']/ul[@class='criteria c_list']/li[starts-with(@id, 'ach')][@class='c_list_col criteriamet']").each do |criteria|
#            @criteriaAchievement = Achievement.searchForAchievement("#{criteria['id']}")
#
#            criteriaInfo = characterAchievementFrame.xpath("//div/div/div[@id='#{achieveID['id']}']/ul[@class='criteria c_list']/li[@id='#{criteria['id']}'][@class='c_list_col criteriamet']")
#
#            criteriaText = criteriaInfo.inner_html
#            criteriaText.split("(")
#            criteriaText.gsub(")", "")
#            name = criteriaText[0]
#            points = criteriaText[1]
#
#            puts name
#            puts points

            #criteriaInfo.inner_html = name (points)
            #need to split on the (
            #criteriaInfo[0] = name
            #criteriaInfo[1].gsub "(" and ")" = points
            #calculate total criteria points

          end
        end
      #characterAchievementFrame.xpath("//div/div/div[starts-with(@id, 'ach')]").each do |achieveID|

        @achievement = Achievement.searchForAchievement("#{achieveID['id']}") #Find completed achievements

        if category.category_id == 81 #feat of strengths category
          title_xpath = "//div[@id='#{achieveID['id']}']/div[2]"
          description_xpath = "//div[@id='#{achieveID['id']}']/div[3]"
          
          points = "0"
          title = characterAchievementFrame.xpath(title_xpath)
          description = characterAchievementFrame.xpath(description_xpath)
          
          if @achievement.to_s == ""  #check if achievement is in database, if not add
            Achievement.addAchievement("#{achieveID['id']}", category.category_id, points, title.inner_html, description.inner_html)
          else                                            #update existing achievement attributes if any are null
            Achievement.updateAchievementAttributes("#{achieveID['id']}", category.category_id, points, title.inner_html, description.inner_html, "1")
          end
          
        else
          title_xpath = "//div/div/div[@id='#{achieveID['id']}']/div[3]"
          description_xpath = "//div/div/div[@id='#{achieveID['id']}']/div[4]"
          achievement_value_xpath = "//div/div/div[@id='#{achieveID['id']}']/div[1]/div"

          #points = achieve points - total criteria points
          points = characterAchievementFrame.xpath(achievement_value_xpath)
          title = characterAchievementFrame.xpath(title_xpath)
          description = characterAchievementFrame.xpath(description_xpath)

          if @achievement.to_s == ""  #check if achievement is in database, if not add
            Achievement.addAchievement("#{achieveID['id']}", category.category_id, points.inner_html, title.inner_html, description.inner_html)
          else                                            #update existing achievement attributes if any are null
            Achievement.updateAchievementAttributes("#{achieveID['id']}", category.category_id, points.inner_html, title.inner_html, description.inner_html, "1")
          end
          
        end

        @characterAchievements = CharacterAchievement.findByCharacterID(@character[0].id)

        if @characterAchievements.to_s == ""
          CharacterAchievement.createCharacterAchievement(@character[0].id, @achievement[0].id, 1)
        else
          @achievementID = CharacterAchievement.findByCharacterAndAchievement(@character[0].id, @achievement[0].id)

          if @achievementID.to_s == ""  #if achievement id does not exist, add the achievement
            CharacterAchievement.createCharacterAchievement(@character[0].id, @achievement[0].id, 1)
          end
          
        end

      end
    end
  end

  getAchievesByCharacterName("Savrom", "Illidan")


  #image_xpath = "//div/div/div[@id='#{achieveID['id']}']/div[2]/img"
  #image_url = "http://www.wowarmory.com/wow-icons/_images/51x51/achievement_quests_completed_08.jpg"

  #TO DO
  #for each achivement ID, check to see if there is a <ul class="criteria_c_list">
          #if there is, get the <li id of each achieve id of each plus description and points .inner_html break at (xx)
end



#####
#Open the achievement page
#For each achievement
#       Check if there is criteria
#               If Criteria
#                       Get ach ID, name and points
#                       Get total points and subtract from main achievment points
#                       Set new main achievement points as the new point value
#
#####