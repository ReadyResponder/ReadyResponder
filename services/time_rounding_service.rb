class TimeRoundingService

  def initialize(object_to_adjust)
    @adjustee = object_to_adjust
  end

  def closest_fifteen
    truncate_seconds
    @adjustee.start_time = nearest_fifteen_after(@adjustee.start_time)
    @adjustee.end_time = nearest_fifteen_before(@adjustee.end_time)
    @adjustee
  end

  private

  def truncate_seconds
    @adjustee.start_time = @adjustee.start_time.change(:usec => 0, :sec => 0)
    @adjustee.end_time = @adjustee.end_time.change(:usec => 0, :sec => 0)
  end

  def nearest_fifteen_after time
    minutes = time.min
    minutes = ((minutes / 60.0 * 4).ceil / 4.0 * 60).to_i
    if minutes == 60
      minutes = 0
      time = time.advance(:hours => 1)
    end
    time.change(:min => minutes)
  end

  def nearest_fifteen_before time
    minutes = time.min
    minutes = ((minutes / 60.0 * 4).floor / 4.0 * 60).to_i
    time.change(:min => minutes)
  end

end

