include Warden::Test::Helpers
Warden.test_mode!

User.subclasses.each do |subclass|
  type = subclass.name.downcase
  # Feature: User index page
  #   As a user
  #   I want to see a list of users
  #   So I can see who has registered
  feature 'User index page', :devise do
    after(:each) do
      Warden.test_reset!
    end

    # Scenario: User listed on index page
    #   Given I am signed in
    #   When I visit the user index page
    #   Then I see my own email address
    scenario "#{type} sees own email address" do
      user = FactoryGirl.create(type)
      login_as(user, scope: :user)
      visit send("#{type.pluralize}_path")
      expect(page).to have_content user.email
    end
  end
end
