include Warden::Test::Helpers
Warden.test_mode!

feature 'Skillings management' do
  after(:each) do
    Warden.test_reset!
  end

  scenario 'worker can add skillings' do
    skills = %w(thinker doer)
    worker = FactoryGirl.create(:worker)
    worker.skills_list = skills
    login_as(worker, scope: :user)
    visit skills_worker_path(worker)
    expect(page).to have_content(/.*#{skills[0]}.*|.*#{skills[1]}.*/)
  end

  scenario 'Costumer can see worker skills' do
    worker = FactoryGirl.create(:worker)
    Faker::Hipster.words(10).each do |skill|
      skill = FactoryGirl.create(:skill, name: skill)
      FactoryGirl.create(:skilling, worker: worker, skill: skill)
    end
    costumer = FactoryGirl.create(:costumer)
    login_as(costumer, scope: :user)
    visit worker_path(worker)
    expect(page).to have_content worker.skills.pluck(:name).join(' ')
  end

end
