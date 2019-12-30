class SengaRequest < ApplicationRecord
  belongs_to :user
  belongs_to :senga
  before_create :event_new
  before_destroy :event_destroy
  before_update :event_update
  def event_new
    Event.create(:user_id => self.user_id,:senga_id => self.senga_id,:event_type => 'request')
  end
  def event_destroy
    Event.find_by(:user_id => self.user_id,:senga_id => self.senga_id, :event_type => 'request').destroy
  end
  def event_update
    if self.permission == true
      Event.create(:user_id => self.user_id,:senga_id => self.senga_id,:event_type => 'confirmed')
    end
  end
end
