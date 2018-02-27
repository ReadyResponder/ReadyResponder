class NotificationsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  before_action :set_form_values, only: [:new, :edit, :create, :update]

  def index
    @notifications = Notification.all
    @page_title = "All Notifications"
  end

  def show
    @event = @notification.event
    @last_editor = last_editor(@notification)
  end

  def new
    if @event.present?
      @notification = @event.notifications.new
      @event.start_time.strftime('%a %b %d %k:%M')
      @event.end_time.strftime('%a %b %d %k:%M')
    else
      @notification = Notification.new
    end
    @notification.subject = "Please provide availability "
    # @statuses = @notification.available_statuses
    @notification.status = "Active"
  end

  def edit
    @statuses = @notification.available_statuses + [@notification.status]
  end

  def create
    @notification = Notification.new(notification_params)
    if @notification.save
      if @notification.status == "Active"
        begin
          @notification.activate!
        rescue Message::SendNotificationTextMessage::InvalidClient
          flash[:error] = 'Notification failed to deliver, no valid delivery client.'
          return render :new
        end
      end
      redirect_to @notification.event || @notification, notice: 'Notification was successfully created.'
    else
      render :new
    end
  end

  def update
    if @notification.update(notification_params)
      if @notification.status == "Active"
        @notification.activate!
      end
      redirect_to @notification.event || @notification, notice: 'Notification was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @notification.destroy
    redirect_to notifications_url, notice: 'Notification was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.

    def set_form_values
      @statuses = ["Active"]
      @event = params[:event_id].present? ? Event.find(params[:event_id]) : @notification.event
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
