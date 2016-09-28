# A helper for validating that first_attr_name is before second_attr_name chronologically
# Unlike many validation methods, this accepts two and only two arguments.
# Usage within a Model:
# validates_chronology :start_time, :end_time

ActiveRecord::Base.class_eval do
  def self.validates_chronology(first_attr_name, second_attr_name)
    validates_each(first_attr_name) do |record, attr_name, value|
      first_time = value
      second_time = record.send(second_attr_name)
      if first_time.present? and second_time.present? and second_time < first_time
        record.errors.add(first_attr_name, "must be before '#{human_attribute_name(second_attr_name)}', unless you are the Doctor")
        record.errors.add(second_attr_name, "must be after '#{human_attribute_name(first_attr_name)}', unless you are the Doctor")
      end
    end
  end
end
