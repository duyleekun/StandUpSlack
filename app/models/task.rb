class Task < ActiveRecord::Base
  belongs_to :user
  enum type: [:completed, :upcoming, :issue]

  def self.inheritance_column
    nil
  end

  before_save do
    case self.description
      when /^\-\s*(.+)/
        self.type = :completed
      when /^\+\s*(.+)/
        self.type = :upcoming
      else
        self.type = :issue
    end
    self.description= self.description.scan(/[-+*]?\s*(.+)/).flatten.last
  end

end
