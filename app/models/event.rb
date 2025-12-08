class Event < ApplicationRecord
  belongs_to :author, class_name: "User"

  validates :description, length: { maximum: 100 }
end
