class HelpdocsController < ApplicationController

  def index
    dir = Rails.root.join('app', 'views', 'helpdocs')
    @files = Dir.entries(dir).select{|f| f.match(/^\w.*\.md*/)}
      .map{|f| f.gsub(/\..*/, '')}.sort
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
    respond_to do |format|
      format.html { render params[:id] }
    end
  end

end
