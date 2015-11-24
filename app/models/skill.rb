class Skill < ActiveRecord::Base
  has_many :skillings, dependent: :destroy
  validates_presence_of :name
end
