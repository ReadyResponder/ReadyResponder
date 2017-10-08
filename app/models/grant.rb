class Grant < ActiveRecord::Base
  has_paper_trail

  attr_accessible :name, :description, :start_date, :end_date, :status

  validate :end_date_after_start_date?

  has_many :items

  scope :active, -> { where(status: "Active") }

  STATUS_CHOICES = [ "Active", "Expired" ]

  private

  def end_date_after_start_date?
    if end_date < start_date
      errors.add :end_date, "must be after start date"
    end
  end
end
