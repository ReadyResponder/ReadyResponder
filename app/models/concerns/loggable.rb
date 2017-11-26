module Loggable
  extend ActiveSupport::Concern

  included do
    after_update :log_changes_if_updated

    private
      def log_changes_if_updated
        log_changes if changes.any?
      end

      def log_changes
        SystemActivityLog.create!(
          user: modified_by,
          message: message,
          category: self.class.name
        )
      end

      def modified_by
        if paper_trail.try(:originator)
          User.find(paper_trail.try(:originator))
        end
      end

      # Can be overriden in the class for a more specific message
      def message
        "Updated #{self.class.name} #{id}, #{changes_details}"
      end

      def changes_details
        dup = changes
        dup.delete("updated_at")

        [].tap do |details|
          dup.each do |attr_name, arr|
            details << "#{attr_name} changed from '#{arr[0]}' to '#{arr[1]}'"
          end
        end.join(", ")
      end
  end
end
