include Warden::Test::Helpers
Warden.test_mode!

# Feature: User profile page
#   As a user
#   I want to visit my user profile page
#   So I can see my personal account data
feature 'User profile page', :devise do
  before(:each) do
    Capybara.current_session.driver.header 'Referer', root_path
  end
  after(:each) do
    Warden.test_reset!
  end
  User.subclasses.each do |subclass|
    type = subclass.name.downcase
    scenario "#{type} sees own profile" do
      user = FactoryGirl.create(type)
      login_as(user, scope: :user)
      visit send("#{type}_path", user)
      expect(page).to have_content type.camelcase
      expect(page).to have_content user.email
    end
  end

  scenario "Costumer can see worker's profile" do
    costumer = FactoryGirl.create(:costumer)
    worker = FactoryGirl.create(:worker)
    login_as(costumer, scope: :user)
    visit send('worker_path', worker)
    expect(page).to have_content worker.email
  end

  scenario "Worker can see other worker's profile" do
    worker1 = FactoryGirl.create(:worker)
    worker2 = FactoryGirl.create(:worker)
    login_as(worker1, scope: :user)
    visit send('worker_path', worker2)
    expect(page).to have_content worker2.email
  end

  scenario "Worker cannot see costumer's profile" do
    costumer = FactoryGirl.create(:costumer)
    worker = FactoryGirl.create(:worker)
    login_as(worker, scope: :user)
    visit send('costumer_path', costumer)
    expect(page).to have_content 'Access denied'
  end
end
