require 'rubygems'
require 'active_record'
require 'active_support'

$config = YAML.load_file(File.join(File.dirname(__FILE__), 'database.yml'))

class WowAchievementConnection < ActiveRecord::Base

  ActiveSupport::Deprecation.silenced = true
     self.abstract_class = true
     establish_connection $config['development']
end