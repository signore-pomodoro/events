class Event < ApplicationRecord
   # Событие принадлежит юзеру
   belongs_to :user
   has_many :comments

   has_many :subscribers, through: :subscriptions, source: :user
   # Валидируем юзера на присутствие. В Rails 5 связи 
   # валидируются по умолчанию
   validates :user, presence: true
end
