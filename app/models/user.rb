class User < ActiveRecord::Base
  attr_accessible :name, :pwd, :register_time, :tag
end
