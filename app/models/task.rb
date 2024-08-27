# app/models/task.rb
class Task < ApplicationRecord
  has_many :task_assignments
  has_many :users, through: :task_assignments
  belongs_to :created_by, class_name: 'User', foreign_key: 'created_by'
end
