class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_action :set_paper_trail_whodunnit

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access Denied"
    redirect_to root_url
  end

  def download
    node = instance_variable_get("@#{controller_name.singularize}")
    path = node.send(params['type']).path
    send_file path, x_sendfile: true
  end

  def last_editor(the_object)
    if the_object.paper_trail.try(:originator)
      User.find(the_object.paper_trail.originator).try(:fullname)
    end
  end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << :username
      devise_parameter_sanitizer.for(:account_update) << :username
    end
end
