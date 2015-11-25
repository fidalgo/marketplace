module SearchableSkills
  extend ActiveSupport::Concern

  module ClassMethods
    def find_workers_by_skill_name(skills) # quando tenho 2 skills falha
      skill_ids = skill_ids(skills)
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

    private

    def skill_ids(skills)
      return Skill.uniq.pluck(:id) unless skills.present?
      Skill.where('name ILIKE ANY ( array[?] )', sql_values(skills)).pluck(:id)
    end

    def sql_values(skills)
      skills.split(',').map { |skill| "%#{skill.strip}%" } if skills.present?
    end
  end
end
