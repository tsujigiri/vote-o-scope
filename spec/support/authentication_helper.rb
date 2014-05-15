module AuthenticationHelper
  def web_sign_in
    email = 'test@example.com'
    password = 'test'
    user = User.find_or_initialize_by(email: email)
    user.password = user.password_confirmation = password
    user.save!
    visit('/users/sign_in')
    fill_in('Email', with: email)
    fill_in('Password', with: password)
    click_on('Sign in')
  end
end
