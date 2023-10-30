# Preview all emails at http://localhost:3000/rails/mailers/users_mailer
class UsersMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/users_mailer/codeVerification
  def codeVerification
    UsersMailer.codeVerification
  end

  # Preview this email at http://localhost:3000/rails/mailers/users_mailer/signInTime
  def signInTime
    UsersMailer.signInTime
  end

end
