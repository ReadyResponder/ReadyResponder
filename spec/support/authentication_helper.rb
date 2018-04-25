module AuthenticationHelper
  # Feature spec helper to login as a certain role.
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

  # Controller helper to login as an editor.
  def login_admin
    login_as('Editor')
  end

  # Controller helper to login as a certain role.
  # @param [String] the role to become: 'Editor', 'Manager', 'Reader', etc
  def login_as(role)
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user = create(:user, roles: [create(:role, name: role.to_s.titleize)])
    sign_in user
  end

  def login_manager
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user = FactoryBot.create(:user)
    r = create(:role, name: 'Manager')
    user.roles << r
    sign_in user
  end
end

RSpec.configure do |c|
  c.include AuthenticationHelper, type: :feature
end
