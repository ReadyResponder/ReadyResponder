class Grant < ActiveRecord::Base
  has_many :items

  validate :end_date_after_start_date?

  scope :active, -> { where(status: "Active") }

  STATUS_CHOICES = [ "Active", "Expired" ]

  private

  def end_date_after_start_date?
    if end_date < start_date
      errors.add :end_date, "must be after start date"
    end
  end
end
