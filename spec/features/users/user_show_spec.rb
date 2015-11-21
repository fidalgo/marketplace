include Warden::Test::Helpers
Warden.test_mode!

User.subclasses.each do |subclass|
  type = subclass.name.downcase
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

    # Scenario: User sees own profile
    #   Given I am signed in
    #   When I visit the user profile page
    #   Then I see my own email address
    scenario "#{type} sees own profile" do
      user = FactoryGirl.create(type)
      login_as(user, scope: :user)
      visit send("#{type}_path", user)
      expect(page).to have_content type.camelcase
      expect(page).to have_content user.email
    end

    # Scenario: User cannot see another user's profile
    #   Given I am signed in
    #   When I visit another user's profile
    #   Then I see an 'access denied' message
    scenario "#{type} cannot see another user's profile" do
      me = FactoryGirl.create(type)
      other = FactoryGirl.create(type)
      login_as(me, scope: :user)
      visit send("#{type}_path", other)
      expect(page).to have_content 'Access denied.'
    end
  end
end
