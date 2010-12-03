require File.dirname(__FILE__) + "  /../models/character_achievement.rb"

class HomeController < ApplicationController
  def show
    @uniqueAchievements = CharacterAchievement.get_unique_achievements("1")
#    @uniqueAchievements.each do |achievement|
#      @achievement =Achievement.search_for_achievement(achievement)
#    end
  end

end
