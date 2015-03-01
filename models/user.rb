class User < ActiveRecord::Base
  self.table_name = "users"
  self.inheritance_column = :_type_disabled # originally it is ':type' so we can't keep a column named type in our tables
  has_one :user_config

  STATUS_NEW = 'new'
end
