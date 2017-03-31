class HelpdocsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  def index
    dir = Rails.root.join('app', 'views', 'helpdocs')
    @files = (
      (Dir.entries(dir).select{|f| f.match(/^\w.*\.md*/)}
      .map{|f| f.gsub(/\..*/, '')}) - ['index']
    ).sort
    # todo eventually use `tree` or something to display a
    # tree of available helpdocs. BUT #show doesn't currently
    # support a tree of them yet.

  end
  # GET /helpdocs/1
  def show
    if params[:id] == 'index'
      redirect_to action: 'index', status: :moved_permanently
      return
    end
    file_name = "#{File.basename(params[:id])}.md"
    path = Rails.root.join('app', 'views', 'helpdocs', file_name)
    if File.exist? path
      respond_to do |format|
        format.html {
          render file_name
        }
      end
    end
  end

end
