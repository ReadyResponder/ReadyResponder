def login_as_editor
  user = create(:user, roles: [create(:role, name: 'Editor')])
  login(user)
end

# use this for request specs
def login(user)
  post_via_redirect user_session_path, 'user[email]' => user.email, 'user[password]' => user.password
end