module Loggable
  extend ActiveSupport::Concern

  included do
    after_update :log_changes_if_updated

    def self.modified_by=(user)
      @modified_by ||= user
    end

    def self.modified_by
      @modified_by.presence
    end

    private
      def log_changes_if_updated
        log_changes if previous_changes.any?
      end

      def log_changes
        SystemActivityLog.create!(
          user: modified_by,
          message: message,
          category: self.class.name
        )
      end

      # Can be overriden in the class for a more specific message
      def message
        "Updated #{self.class.name} #{id}, #{changes_details}"
      end

      def changes_details
        previous_changes.delete("updated_at")

        [].tap do |changes|
          previous_changes.each do |attr_name, arr|
            changes << "#{attr_name} changed from '#{arr[0]}' to '#{arr[1]}'"
          end
        end.join(", ")
      end
  end
end
