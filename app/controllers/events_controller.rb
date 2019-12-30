class EventsController < ApplicationController
    
  def notification
    #require "date"
    #now = Date.today
    #date = now.prev_day(10)
    #date = date.strftime("%Y-%m-%d %H:%M:%S")
    #logger.debug date
    mysengalist = Senga.where(:user_id => current_user.id).pluck(:id)
    @requests = Event.where(senga_id: mysengalist).where(:event_type => 'request')
    @posted = Event.where(senga_id: mysengalist).where(:event_type => 'posted')
    @confirmed = Event.where(:user_id => current_user.id).where(:event_type => 'confirmed')
  end
  
end
