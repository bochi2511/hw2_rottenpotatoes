class Movie < ActiveRecord::Base
  def self.get_all_ratings
     self.select(:rating).map(&:rating).uniq.sort
  end
end
