class Email < Channel
  include ActiveModel::ForbiddenAttributesProtection
  belongs_to :person, optional: true
end
