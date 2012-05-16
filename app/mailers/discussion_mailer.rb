class DiscussionMailer < ActionMailer::Base
  default from: "conversation@athirdplace.com"

  def start_discussion(recipient)
    @sender = current_user
    @recipient = recipient

    mail to: user.email, subject: "#{user.first_name} has started a conversation with you."
  end
end
