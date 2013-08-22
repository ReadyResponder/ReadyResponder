class TimeslotPresenter

  def initialize(timeslot, template)
    @timeslot = timeslot
    @template = template
  end

  def the_actual_start
    @timeslot.actual_start_time.to_s(:short) if @timeslot.actual_start_time
  end
end

private
  def h
    @template    
  end