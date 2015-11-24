require 'rails_helper'

RSpec.describe Skilling, type: :model do
  describe '#remove_unused_skills' do
    it do
      worker = FactoryGirl.create(:worker)
      skills = %w(doer thinker)
      worker.update(skills_list: skills)
      expect(Skill.count).to eq(skills.size)
      worker.update(skills_list: [skills.first])
      expect(Skill.count).to eq(1)
    end
  end
end
