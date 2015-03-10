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

  def fetch_tasks
    self.team.client.im.history(channel: self.im_slack_id, oldest: 1.day.ago.to_i).body['messages'].map do |message|
      if message['user'] == self.slack_id
        puts message
        time = Time.at(message['ts'].to_f)
        Task.find_or_create_by(created_at: time, updated_at: time, user_id: self.id, description: message['text'])
      end
    end
    mark_as_read
  end
end
