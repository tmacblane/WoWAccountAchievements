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

  def self.get_achieves_by_character_name(character, realm)

    @character = Character.search_for_character_by_realm(character, realm) #search for character by realm

    if @character.to_s == ""
      @character = Character.add_character(character, realm) #if character does not exist, add to database
    end

    @categories = Categories.find_categories_by_type(0)  #finds all categories of type 0 (achievements)

    @categories.each do |category|    #Loop through each root category id
      characterAchievementFrame = Nokogiri::HTML(open(armoryURL(character, realm, category.category_id))) #set the page
      points = 0
      title = ""
      description = ""     

      #Do for Completed Achieves
      characterAchievementFrame.xpath("//div/div/div[starts-with(@id, 'ach')][@class='achievement']").each do |achieveID|

        title_xpath = "//div[@id='#{achieveID['id']}']/div[@class='achv_title']"
        description_xpath = "//div[@id='#{achieveID['id']}']/div[@class='achv_desc']"
        date_xpath = "//div[@id='#{achieveID['id']}']/div[@class='achv_date']"
        achievement_value_xpath = "//div[@id='#{achieveID['id']}']/div[@class='pointshield']/div"
        image_xpath = "//div[@id='#{achieveID['id']}']/div[@class='firsts_icon'][starts-with(@style, 'background-image')]"
        @achievement = Achievement.search_for_achievement("#{achieveID['id']}") #Find completed achievements
        @characterAchievements = CharacterAchievement.find_by_character_id(@character[0].id)

        #if achievement is a feat of strength
        if category.category_id == 81 #Check if achievement is a feat of strength
          points = ""    #set points to 0 - feats of strength have no points
          title = characterAchievementFrame.xpath(title_xpath).inner_html   #update title variable to inner_html text
          description = characterAchievementFrame.xpath(description_xpath).inner_html   #update description variable to inner_html text

          if @achievement.to_s == ""  #check if achievement is in database, if not add
            Achievement.add_achievement("#{achieveID['id']}", category.category_id, points, title, description)
          else                                            #update existing achievement attributes if any are null
            Achievement.update_achievement_attributes("#{achieveID['id']}", category.category_id, points, title, description, "1")
          end

          image = characterAchievementFrame.xpath(image_xpath)

        else
          points_total = 0
          #Check to see if character achievement has criteria
          if (characterAchievementFrame.xpath("//div/div/div[@id='#{achieveID['id']}']/ul[@class='criteria c_list']/li[starts-with(@id, 'ach')][@class='c_list_col criteriamet']")) != ""
            characterAchievementFrame.xpath("//div/div/div[@id='#{achieveID['id']}']/ul[@class='criteria c_list']/li[starts-with(@id, 'ach')][@class='c_list_col criteriamet']").each do |criteria|
              @criteriaAchievement = Achievement.search_for_achievement("#{criteria['id']}")  #search if achievement has already been recorded

              criteriaAchievementInfo = characterAchievementFrame.xpath("//div/div/div[@id='#{achieveID['id']}']/ul[@class='criteria c_list']/li[@id='#{criteria['id']}'][@class='c_list_col criteriamet']")

              criteriaInfo = criteriaAchievementInfo.inner_html.rstrip
              criteriaInfo = criteriaInfo.split(/ /)

              title = criteriaInfo[0...-1].join(' ')

              points = criteriaInfo[-1].to_s
              points = points.gsub("(", "")
              points = points.gsub(")", "")
              points = points.to_i

              points_total = points_total + points #keeps a running calculation of criteria achievement points

              if @criteriaAchievement.to_s == ""  #check if achievement is in database, if not add
                Achievement.add_achievement("#{criteria['id']}", category.category_id, points, title, description)
              else                                            #update existing achievement attributes if any are null
                Achievement.update_criteria_achievement_attributes("#{criteria['id']}", category.category_id, points, title, "1")
              end

              points = characterAchievementFrame.xpath(achievement_value_xpath).inner_html.to_i - points_total
              title = characterAchievementFrame.xpath(title_xpath).inner_html
              description = characterAchievementFrame.xpath(description_xpath).inner_html

              if @achievement.to_s == ""  #check if achievement is in database, if not add
                Achievement.add_achievement("#{achieveID['id']}", category.category_id, points, title, description)
              else                                            #update existing achievement attributes if any are null
                Achievement.update_achievement_attributes("#{achieveID['id']}", category.category_id, points, title, description, "1")
              end

              #add character criteria achievements
              if @characterAchievements.to_s == ""
                CharacterAchievement.create_character_achievement(@character[0].id, @criteriaAchievement[0].id, 1)
              else
                @achievementID = CharacterAchievement.find_by_character_and_achievement(@character[0].id, @criteriaAchievement[0].id)

                if @achievementID.to_s == ""  #if achievement id does not exist, add the achievement
                  CharacterAchievement.create_character_achievement(@character[0].id, @criteriaAchievement[0].id, 1)
                end
              end
            end
          end

          points = characterAchievementFrame.xpath(achievement_value_xpath).inner_html.to_i - points_total
          title = characterAchievementFrame.xpath(title_xpath).inner_html
          description = characterAchievementFrame.xpath(description_xpath).inner_html

          if @achievement.to_s == ""  #check if achievement is in database, if not add
            Achievement.add_achievement("#{achieveID['id']}", category.category_id, points, title, description)
          else                                            #update existing achievement attributes if any are null
            Achievement.update_achievement_attributes("#{achieveID['id']}", category.category_id, points, title, description, "1")
          end
        end

        #add character achievements
        if @characterAchievements.to_s == ""
          CharacterAchievement.create_character_achievement(@character[0].id, @achievement[0].id, 1)
        else
          @achievementID = CharacterAchievement.find_by_character_and_achievement(@character[0].id, @achievement[0].id)

          if @achievementID.to_s == ""  #if achievement id does not exist, add the achievement
            CharacterAchievement.create_character_achievement(@character[0].id, @achievement[0].id, 1)
          end
        end
      end
    end
  end


  #get_achieves_by_character_name("Mosch", "Illidan")
  get_achieves_by_character_name("Morvas", "Illidan")
  get_achieves_by_character_name("Loganvi", "Illidan")

  #image_xpath = "//div/div/div[@id='#{achieveID['id']}']/div[2]/img"
  #image_url = "http://www.wowarmory.com/wow-icons/_images/51x51/achievement_quests_completed_08.jpg"
end