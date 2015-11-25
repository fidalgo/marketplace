module SearchableSkills
  extend ActiveSupport::Concern

  module ClassMethods
    def find_workers_by_skill_name(skill_name)
      skill_ids = Skill.where('name ILIKE ?', "%#{skill_name}%").pluck(:id)
      worker_ids = Skilling.where(skill: skill_ids).pluck(:worker_id)
      Worker.uniq.includes(:skills).find(worker_ids)
    end

    def find_name_by_match(match)
      if match.present?
        Skill.where('name ILIKE ?', "%#{match}%")
      else
        Skill.uniq.pluck(:name)
      end
    end
  end
end
