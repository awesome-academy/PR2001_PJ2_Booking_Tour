class Notification < ApplicationRecord
  belongs_to :sender_id, class_name: User.name
  belongs_to :receiver_id, class_name: User.name
end
