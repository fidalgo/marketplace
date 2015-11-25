include Warden::Test::Helpers
Warden.test_mode!

feature 'Costumer actions' do
  after(:each) do
    Warden.test_reset!
  end

  scenario 'can search workers skills' do
    worker = FactoryGirl.create(:worker)
    skillings = FactoryGirl.create_list(:skilling, 10, worker: worker)
    costumer = FactoryGirl.create(:costumer)
    login_as(costumer, scope: :user)
    visit search_costumers_path
    fill_in 'skills', with: 'skill'
    click_button 'Search'
  end

  scenario 'get skills results' do
    skill = FactoryGirl.create(:skill, name: 'doer')
    skillings = FactoryGirl.create_list(:skilling, 10, skill: skill)
    costumer = FactoryGirl.create(:costumer)
    login_as(costumer, scope: :user)
    visit search_costumers_path
    fill_in 'skills', with: skill.name
    click_button 'Search'
    expect(page).to have_content "10 Workers with skills: #{skill.name}"
  end
end
