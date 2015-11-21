module Features
  module SessionHelpers
    def sign_up_with(email, password, confirmation, type)
      visit send("new_#{type}_registration_path")
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      fill_in 'Password confirmation', :with => confirmation
      click_button 'Sign up'
    end

    def signin(email, password, type)
      visit send("new_#{type}_session_path")
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      click_button 'Sign in'
    end
  end
end
