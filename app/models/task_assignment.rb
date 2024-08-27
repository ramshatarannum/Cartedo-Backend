# app/models/task_assignment.rb
class TaskAssignment < ApplicationRecord
  belongs_to :user
  belongs_to :task
end
