require 'rails_helper'

RSpec.describe Worker, type: :model do
  subject { create(:worker) }

  it { should have_many :skillings }
  it { should have_many :skills }

  describe '#skills_list' do
    it 'returns empty on worker creation' do
      expect(subject.skills_list).to be_empty
    end
    it 'assigns the skill list' do
      skills = %w(doer thinker)
      subject.update(skills_list: skills)
      expect(subject.skills_list).to eq(skills)
    end

    it 'updates with new skills' do
      skills = %w(doer thinker)
      new_skills = %w(philosofer constructor)
      subject.update(skills_list: skills)
      subject.update(skills_list: new_skills)
      expect(subject.skills_list).to eq(new_skills)
    end

    it 'removes skills when the user is deleted' do
      worker = FactoryGirl.create(:worker)
      another_worker = FactoryGirl.create(:worker)
      skills = %w(doer thinker)
      worker.update(skills_list: skills)
      another_worker.update(skills_list: skills)
      expect(Skill.count).to eq(skills.size)
      expect(Skilling.count).to eq(2 * skills.size)
      worker.update(skills_list: [])
      expect(Skill.count).to eq(skills.size)
      expect(Skilling.count).to eq(skills.size)
      another_worker.update(skills_list: [])
      expect(Skill.count).to eq(0)
    end
  end
end
