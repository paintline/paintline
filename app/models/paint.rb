class Paint < ApplicationRecord
  belongs_to :user
  belongs_to :senga
  mount_uploader :image, ImagesUploader
  before_create :event_new
  def event_new
    Event.create(:user_id => self.user_id,:senga_id => self.senga_id,:event_type => 'posted')
  end
end
