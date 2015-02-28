class UserConfig < ActiveRecord::Base
  self.table_name = "user_config"
  self.inheritance_column = :_type_disabled # originally it is ':type' so we can't keep a column named type in our tables
  belongs_to :user
end
