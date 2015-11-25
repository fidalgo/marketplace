class Worker < User
  include SearchableSkills
  
  has_many :skillings, dependent: :destroy
  has_many :skills, through: :skillings

  def skills_list
    skills.pluck(:name)
  end

  def skills_list=(new_skills)
    skill_names = new_skills.flatten.uniq.map(&:strip).delete_if(&:blank?)
    delete_skills(skills_list - skill_names) if skills_list.present?
    skill_names.each do |skill_name|
      skill = Skill.where(name: skill_name).first_or_create!
      skillings.where(skill: skill).first_or_create!
    end
  end

  private

  def delete_skills(skills_list)
    logger.info "DELETE: #{skills_list}"
    skills_list.each do |skill_to_delete|
      skill = Skill.where(name: skill_to_delete)
      skillings.where(skill: skill).each(&:destroy)
    end
  end
end
