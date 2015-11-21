include Warden::Test::Helpers
Warden.test_mode!

User.subclasses.each do |subclass|
  type = subclass.name.downcase

  # Feature: User edit
  #   As a user
  #   I want to edit my user profile
  #   So I can change my email address
  feature "#{type} edit", :devise do
    after(:each) do
      Warden.test_reset!
    end

    # Scenario: User changes email address
    #   Given I am signed in
    #   When I change my email address
    #   Then I see an account updated message
    scenario "#{type} changes email address" do
      user = FactoryGirl.create(type)
      login_as(user, scope: type)
      visit send("edit_#{type}_registration_path", user)
      fill_in 'Email', with: 'newemail@example.com'
      fill_in 'Current password', with: user.password
      click_button 'Update'
      txts = [I18n.t('devise.registrations.updated'),
              I18n.t('devise.registrations.update_needs_confirmation')]
      expect(page).to have_content(/.*#{txts[0]}.*|.*#{txts[1]}.*/)
    end

    # Scenario: User cannot edit another user's profile
    #   Given I am signed in
    #   When I try to edit another user's profile
    #   Then I see my own 'edit profile' page
    scenario "#{type} cannot cannot edit another user's profile", :me do
      me = FactoryGirl.create(type)
      other = FactoryGirl.create(type, email: 'other@example.com')
      login_as(me, scope: type)
      visit send("edit_#{type}_registration_path", other)
      expect(page).to have_content "Edit #{type.camelcase}"
      expect(page).to have_field('Email', with: me.email)
    end
  end
end
