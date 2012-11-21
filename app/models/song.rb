class Song < ActiveRecord::Base
  attr_accessible :name, :yt_id
  belongs_to :user, :foreign_key => :user_id
end
