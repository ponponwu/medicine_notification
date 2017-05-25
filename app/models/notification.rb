# notify (user, medicine, time) as PK
class Notification < ApplicationRecord
  belongs_to :users
end
