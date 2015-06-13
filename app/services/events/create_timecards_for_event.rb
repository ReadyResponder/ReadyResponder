# This is a service because it crosses both
# events and timecards.

# This will involve creating timecards for some people who may
# be unavailable, such as already in another event.
# Also, the event may have that group as ineligable.
#

module Events

  class CreateTimecards

    def self.call(event)
      begin
        # I need to iterate of the people for the event
      rescue => error
        Rails.logger.debug "Error while creating timecards for event: #{error.message}"
      end
    end

    private

    def get_location_ids_with_duplicate_floorplans
      Floorplan.all.count_by(&:location_id).select{|location, qty| qty > 1 unless location.nil? }.map{|loc, qty| loc}
    end

  end

end
