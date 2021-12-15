class Event < ApplicationRecord
   # Событие принадлежит юзеру
   belongs_to :user

   # Валидируем юзера на присутствие. В Rails 5 связи 
   # валидируются по умолчанию
   validates :user, presence: true
end
