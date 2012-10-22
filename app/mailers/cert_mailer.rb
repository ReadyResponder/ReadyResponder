class CertMailer < ActionMailer::Base
  default from: "records@billericaema.org"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.cert_mailer.cert_expiring.subject
  #
  def cert_expiring(person)
    @person = person

    #mail to: person.contacts.emails.info, subject: 'One of your certifications is expiring'
  end
end
