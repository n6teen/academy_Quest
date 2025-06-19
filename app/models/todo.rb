class Todo < ApplicationRecord
  validates :title, presence: true, length: { minimum: 1 }
  validates :status, inclusion: { in: [ true, false ] }
end
