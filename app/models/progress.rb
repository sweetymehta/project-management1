class Progress < ActiveRecord::Base
  attr_accessible :name
  has_many :tasks

  validates :name , :uniqueness => true

end
