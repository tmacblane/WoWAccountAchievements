require File.dirname(__FILE__) + "  /../models/character_achievement.rb"

class HomeController < ApplicationController
  def show
    @uniqueAchievements = CharacterAchievement.get_unique_achievements("3")
  end

end
