module TeamsHelper
  def slackify_task(task)
    case task.type
      when 'completed'
        emoji = ':checkered_flag:'
      when 'upcoming'
        emoji = ':clock9:'
      else
        emoji =':exclamation:'
    end
    "#{emoji} #{task.description}"
  end
end
