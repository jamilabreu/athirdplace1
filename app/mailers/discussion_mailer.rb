class DiscussionMailer < ActionMailer::Base
  default from: "\"[ thirdplace ]\" <conversations@athirdplace.com>"

  def start_discussion(sender, recipient, community)
    @sender = sender
    @recipient = recipient
    @community = community
  
    mail from: "\"#{@community.name} Student + Alumni Network\" <conversations@athirdplace.com>", to: @recipient.email, subject: "#{@sender.first_name} has started a conversation with you."
  end
  
  def continue_discussion(sender, recipient, community)
    @sender = sender
    @recipient = recipient
    @community = community
  
    mail from: "\"#{@community.name} Student + Alumni Network\" <conversations@athirdplace.com>", to: @recipient.email, subject: "#{@sender.first_name} has continued #{@sender.gender.join.titleize == "Male" ? 'his' : 'her'} conversation with you."
  end
end
