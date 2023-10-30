class UsersMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.users_mailer.codeVerification.subject
  #
  def codeVerification(user, code)
    @greeting = "Hi"
    @code = code
    # mail(to: user.email, subject: "Codigo de verificación")
    mail(to: "jsantander1219@gmail.com", subject: "Codigo de verificación")
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.users_mailer.signInTime.subject
  #
  def signInTime
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
