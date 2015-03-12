require 'slack'

class Team < ActiveRecord::Base
  has_many :users
  has_many :tasks, through: :users

  def client
    @_client ||= Slack::RPC::Client.new(self.token)
  end

  def fetch_tasks
    self.users.includes(:team).each(&:fetch_tasks)
  end

  before_validation do
    response = client.auth.test.body
    raise 'Invalid token' unless response['ok']
    self.name = response['team']
    self.slack_id = response['team_id']
  end

  after_create do
    self.update_users
  end


  def update_users
    client.users.list.body['members'].each do |member|
      puts member
      unless member['is_bot'] || member['deleted']
        user = User.find_or_initialize_by(slack_id: member['id'], team_id: self.id)
        user.name = member['name']
        user.real_name = member['real_name']
        user.reload_slack_im_id
        user.save
      end
    end
  end
end
