repository do
  event = Event.new(:name => "Ruby DCamp", :description => "Awesome conference dudes!", :id => 1)

  session = Session.new(:name => "The awesomeness that is Data Mapper", :description => "w00t w00t", :id => 1)
  tag = Tag.new(:name => "Cool beans", :id => 1)
  tag.taggable_class = Session
  tag.taggable_id = session.id
  tag.save!

#  session.tags << tag

  event.sessions << session
  
  event.save!

  user = User.new(:first_name => "Cleborp", :last_name => "Light", :email => "cleborp@theretard.com", :id => 1)
  
  attendee = Attendee.new(:id => 1)
  attendee.user = user
  attendee.event = event
  attendee.save!
  
  comment = Comment.new(:subject => "meep", :message => "Bong.", :id => 1)
  comment.user = user
  comment.commentable_class = Session
  comment.commentable_id = session.id
  #session.comments << comment
  comment.save!
  
  vote = Vote.new(:id => 1)
  vote.attendee = attendee
  vote.value = 1
  vote.session = session
  vote.save!
end