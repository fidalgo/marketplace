require 'rails_helper'

RSpec.describe Skill, type: :model do
  it 'removes the skillings when the Skill is deleted' do
    worker = FactoryGirl.create(:worker)
    skills = %w(doer thinker)
    worker.update(skills_list: skills)
    expect(Skill.count).to eq(skills.size)
    expect(Skilling.count).to eq(skills.size)
    worker.update(skills_list: [skills.first])
    expect(Skill.count).to eq(1)
    expect(Skilling.count).to eq(1)
  end
end
