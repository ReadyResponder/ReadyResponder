namespace :timecards do
  desc 'Mark stale timecards with status: Error.
    
  Usage: rails timecards:mark_stale_as_error
        
  Stale timecards are those that are still open and were started more
  than TIMECARD_MAXIMUM_HOURS.

  The TIMECARD_MAXIMUM_HOURS is stored as an instance of the Setting model.
  If it is not defined, this rake task will throw an exception.'
  task :mark_stale_as_error => :environment do
    hour_limit = Setting.get 'TIMECARD_MAXIMUM_HOURS'

    if hour_limit.nil?
      raise Setting::MissingSettingError.new('TIMECARD_MAXIMUM_HOURS not found. You can set it up
as an ENVironment variable or add it as a Setting.')
    end

    updated_records = Timecard.open_for_more_than(hour_limit).mark_as_error!
    puts "-- #{updated_records} marked as stale." unless Rails.env == 'test'
  end
end
