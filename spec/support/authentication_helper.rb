module AuthenticationHelper

  def sign_in_as(role_name)
    somebody = create(:user)
    if role_name
      r = create(:role, name: role_name)
      somebody.roles << r
    end
    visit new_user_session_path
    fill_in 'user_email', with: somebody.email
    fill_in 'user_password', with: somebody.password
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

RSpec.configure do |c|
  c.include AuthenticationHelper, type: :feature
end
