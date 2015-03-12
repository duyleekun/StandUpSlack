class Task < ActiveRecord::Base
  belongs_to :user
  enum type: [:completed, :upcoming, :issue]

  def self.inheritance_column
    nil
  end

  def self.create_from_message(message)
    # puts message
    user = User.find_by(slack_id: message['user'])
    if user
      message['text'].split("\n").each do |description|
        case description
          when /^\(?\-\)?\s*(.+)/
            type = Task.types[:completed]
          when /^\(?\+\)?\s*(.+)/
            type = Task.types[:upcoming]
          else
            type = Task.types[:issue]
        end
        description= description.scan(/\(?[-+*]?\)?\s*(.+)/).flatten.last
        time = Time.at(message['ts'].to_f)
        Task.find_or_create_by(created_at: time, updated_at: time, user_id: user.id, description: description,type: type)
      end
    end
  end
end
