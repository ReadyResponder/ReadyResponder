class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
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
    def set_return_path
      if request.referer
        (session[:before_show] = request.referer unless request.referer.include? "edit")
      else
        (session[:before_show] = people_path)
      end
    end

    def set_referrer_path
      session[:referrer] = request.referer
    end

    def referrer_or(fallback_destination)
      session.delete(:referrer) || fallback_destination
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
      devise_parameter_sanitizer.permit(:account_update, keys: [:username])
    end
end
