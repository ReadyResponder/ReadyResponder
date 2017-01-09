class NotificationsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_notification, only: [:show, :edit, :update, :destroy]
  before_action :set_choices, only: [:new, :edit]

  # GET /notifications
  def index
    @notifications = Notification.all
    @page_title = "All Notifications"
  end

  # GET /notifications/1
  def show
    @event = @notification.event
  end

  # GET /notifications/new
  def new
    @event = Event.find(params[:event_id])
    @notification = @event.notifications.new
    @notification.departments = @dept_choices
    start_time_display = @event.start_time.strftime('%a %b %d %k:%M')
    end_time_display = @event.end_time.strftime('%a %b %d %k:%M')
    @notification.subject = "Please provide availability "
    @notification.subject += "for #{@event.title} [#{@event.id_code}] "
    @notification.subject += "from #{start_time_display} to #{end_time_display}"
    # @statuses = @notification.available_statuses
    @statuses = ["Active"]
    @notification.status = "Active"
  end

  # GET /notifications/1/edit
  def edit
    @statuses = @notification.available_statuses + [@notification.status]
    @event = @notification.event
  end

  # POST /notifications
  def create
    @notification = Notification.new(notification_params)
    if @notification.save
      if @notification.status == "Active"
        @notification.activate!
      end
      redirect_to @notification.event, notice: 'Notification was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /notifications/1
  def update
    if @notification.update(notification_params)
      if @notification.status == "Active"
        @notification.activate!
      end
      redirect_to @notification.event, notice: 'Notification was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /notifications/1
  def destroy
    @notification.destroy
    redirect_to notifications_url, notice: 'Notification was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notification
      @notification = Notification.find(params[:id])
    end

    def set_choices
      @dept_choices = @event ? @event.departments.managing_people : Department.managing_people
      @purpose_choices = [["Request for Availability", "Availability"],
                          ["Info only", "FYI"],
                          ["Notify with Acknowledgment", "Acknowledgment"]]

    end

    # Only allow a trusted parameter "white list" through.
    def notification_params
      params.require(:notification).permit(:subject, :body, :event_id, :status,
         :author_id, :time_to_live, :interval, :iterations_to_escalation,
         :groups, :scheduled_start_time, :start_time, :channels, :purpose,
         :divisions, :department_ids => [])
    end
end
