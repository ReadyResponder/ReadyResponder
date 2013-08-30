class TimecardPresenter

  def initialize(timecard, template)
    @timecard = timecard
    @template = template
  end

  def the_actual_start
    @timecard.actual_start_time.to_s(:short) if @timecard.actual_start_time
  end
end

private
  def h
    @template    
  end