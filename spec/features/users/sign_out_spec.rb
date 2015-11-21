User.subclasses.each do |subclass|
  type = subclass.name.downcase
  # Feature: Sign out
  #   As a user
  #   I want to sign out
  #   So I can protect my account from unauthorized access
  feature 'Sign out', :devise do
    # Scenario: User signs out successfully
    #   Given I am signed in
    #   When I sign out
    #   Then I see a signed out message
    scenario "#{type} signs out successfully" do
      user = FactoryGirl.create(type)
      signin(user.email, user.password, type)
      expect(page).to have_content I18n.t 'devise.sessions.signed_in'
      click_link 'Sign out'
      expect(page).to have_content I18n.t 'devise.sessions.signed_out'
    end
  end
end
