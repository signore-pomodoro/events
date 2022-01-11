class User < ApplicationRecord
  before_validation :set_name, on: :create
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :events
  has_many :comments
  has_many :subscriptions

  # Добавим заодно валидации для юзера
  # Имя не не более 35 символов
  validates :name, presence: true, length: {maximum: 35}
  # Уникальный email по заданному шаблону не более 255
  # символов
  validates :email, presence: true, length: {maximum: 255}
  validates :email, uniqueness: true
  validates :email, format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/

  after_commit :link_subscriptions, on: :create

  private

  def set_name
    self.name = "Товарисч №#{rand(777)}" if self.name.blank?
  end

  def link_subscriptions
    Subscription.where(user_id: nil, user_email: self.email)
      .update_all(user_id: self.id)
  end

end
