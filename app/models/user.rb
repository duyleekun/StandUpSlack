class User < ActiveRecord::Base
  belongs_to :team
  has_many :tasks

  def reload_slack_im_id
    self.im_slack_id = self.team.client.im.open(user: self.slack_id).body['channel']['id']
  end

  def send_im(text)
    self.team.client.chat.postMessage(channel: self.im_slack_id, text: text)
  end

  def mark_as_read
    self.team.client.im.mark(channel: self.im_slack_id, ts: Time.now.to_f.to_s)
  end

  def fetch_tasks(oldest = 1.day.ago)
    self.team.client.im.history(channel: self.im_slack_id, oldest: oldest.to_i).body['messages'].map do |message|
      Task.create_from_message(message)
    end
    mark_as_read
  end
end
