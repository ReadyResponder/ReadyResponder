class Notification < ActiveRecord::Base
  VALID_CHANNELS = [EMAIL = 'email', VOICE = 'voice', TEXT = 'text']
  VALID_STATUSES = [PENDING = 'pending', ACTIVE = 'active', CANCELED = 'canceled',
      COMPLETE = 'complete', EXPIRED = 'expired']

  belongs_to :event

  validates :subject, :body, presence: true
  validates :status, inclusion: { in: VALID_STATUSES }
  validate :channels, :channels_include_only_valid_values

  def channels=(text)
    self[:channels] = text.downcase
  end

  private

  def channels_include_only_valid_values
    if channels.present? && (channels.split(' ') - VALID_CHANNELS).present?
      errors.add(:channels, I18n.t('activerecord.errors.models.notification.attributes.channels.invalid'))
    end
  end
end
