require 'date'

today = Date.today

todo1 = Todo.new(
  date: today.strftime("%Y-%m-%d"),
  text: "task1",
  status: 0,
  priority: 0
)

todo2 = Todo.new(
  date: today.strftime("%Y-%m-%d"),
  text: "task2",
  status: 0,
  priority: 0
)

todo1.save
todo2.save
