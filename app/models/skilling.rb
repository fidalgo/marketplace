class Skilling < ActiveRecord::Base
  belongs_to :skill
  belongs_to :worker

  after_destroy :remove_unused_skills

  private

  def remove_unused_skills
    skill.destroy if skill.reload.skillings.count.zero?
  end
end
