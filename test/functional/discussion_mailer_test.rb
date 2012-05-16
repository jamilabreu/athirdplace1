require 'test_helper'

class DiscussionMailerTest < ActionMailer::TestCase
  test "start_discussion" do
    mail = DiscussionMailer.start_discussion
    assert_equal "Start discussion", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
