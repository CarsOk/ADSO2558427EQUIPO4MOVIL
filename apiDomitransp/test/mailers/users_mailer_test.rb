require "test_helper"

class UsersMailerTest < ActionMailer::TestCase
  test "codeVerification" do
    mail = UsersMailer.codeVerification
    assert_equal "Codeverification", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "signInTime" do
    mail = UsersMailer.signInTime
    assert_equal "Signintime", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
