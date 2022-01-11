FactoryBot.define do
  # Название фабрики 
  factory :comment do
    # Генерируем последовательность уникальных текстов вопроса
    # Параметр n гарантирует уникальность вопроса
    sequence(:body) { |n| "В каком году была космическая одиссея #{n}?" }
  end
end
