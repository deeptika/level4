class Todo < ActiveRecord::Base
  def due_today?
    due_date == Date.today
  end

  def to_displayable_string
    display_status = completed ? "[X]" : "[ ]"
    display_date = due_today? ? nil : due_date
    "#{id}. #{display_status} #{todo_text} #{display_date}"
  end

  def self.overdue
    all.where("due_date < ?", Date.today)
  end

  def self.due_today
    all.where("due_date = ?", Date.today)
  end

  def self.due_later
    all.where("due_date  > ?", Date.today)
  end

  def self.show_list
    puts "\nMy Todo-list"
    puts "\n\n"
    puts "Overdue"
    puts overdue.map { |todo| todo.to_displayable_string }
    puts "\n\n"
    puts "Due Today"
    puts due_today.map { |todo| todo.to_displayable_string }
    puts "\n\n"
    puts "Due Later"
    puts due_later.map { |todo| todo.to_displayable_string }
    puts "\n"
  end

  def self.add_task(task)
    todo_text = :todo_text
    due_in_days = :due_in_days
    create!(todo_text: task[todo_text], due_date: Date.today + task[due_in_days], completed: false)
  end

  def self.mark_as_complete!(id)
    todo = find(id)
    todo.completed = true
    todo.save
    todo
  end
end
