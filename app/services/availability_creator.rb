class AvailabilityCreator
  attr_accessor :availability

  def initialize(**availability_opts)
    @availability = Availability.new(availability_opts)
  end

  def call
    @availability.transaction do
      process_containing  if containing_availabilities.any?
      process_contained   if contained_availabilities.any?
      process_overlapping if partially_overlapping_availabilities.any?

      @availability.save
    end
  end

  def errors
    @availability.errors
  end

  private

  # This method assumes that a person cannot have active and 
  # overlapping availabilities in the db, thus, there can only
  # be one containing availability
  def process_containing
    containing_availability = containing_availabilities.take
    if status == containing_availability.status
      errors.add :base,
        'A longer availability with the same status covering the given period already exists.'
      raise ActiveRecord::Rollback
    end

    split_availability(containing_availability,
      new_end_time: start_time, new_start_time: end_time)
  end

  def process_contained
    contained_availabilities.each { |a| a.cancel! }
  end

  def process_overlapping
    partially_overlapping_availabilities.each do |a|
      if a.status == status
        @availability.start_time = [a.start_time, @availability.start_time].min
        @availability.end_time   = [a.end_time, @availability.end_time].max
        a.cancel!
      else
        if a.start_time > start_time
          a.update(start_time: end_time)
        else
          a.update(end_time: start_time)
        end
      end
    end
  end

  def split_availability(availability, new_end_time:, new_start_time:)
    new_availability = availability.dup
    new_availability.start_time = new_start_time
    
    availability.update_attributes(end_time: new_end_time)
    new_availability.save
  end

  def person
    @availability.person
  end

  def status
    @availability.status
  end

  def existing_availabilities
    Availability.active.where(person: person)
  end

  def containing_availabilities
    existing_availabilities.containing(start_time..end_time)
  end

  def contained_availabilities
    existing_availabilities.contained_in(start_time..end_time)
  end

  def partially_overlapping_availabilities
    existing_availabilities.partially_overlapping(start_time..end_time)
  end
  
  def start_time
    @availability.start_time
  end

  def end_time
    @availability.end_time
  end
end
