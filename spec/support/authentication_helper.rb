module AuthenticationHelper

  def sign_me_in
    somebody = create(:user)
    r = create(:role, name: 'Editor')
    somebody.roles << r
    visit new_user_session_path
    fill_in 'user_email', :with => somebody.email
    fill_in 'user_password', :with => somebody.password
    click_on 'Sign in'
  end

  def login_admin
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user = FactoryGirl.create(:user)
    r = create(:role, name: 'Editor')
    user.roles << r
    sign_in user
  end
end
