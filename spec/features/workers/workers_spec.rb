include Warden::Test::Helpers
Warden.test_mode!

feature 'Workers management' do
  after(:each) do
    Warden.test_reset!
  end

  scenario 'worker can see all workers' do
    worker = FactoryGirl.create(:worker)
    workers_list = FactoryGirl.create_list(:worker, 10)
    login_as(worker, scope: :user)
    visit workers_path
    expect(page).to have_content workers_list.sample.email
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
