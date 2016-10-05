class Email < Channel
  include ActiveModel::ForbiddenAttributesProtection
  belongs_to :person
end
