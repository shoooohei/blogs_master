class User < ApplicationRecord
  validates :name, presence: true,
            length: { maximum: 30,
                      too_long: "は最大%{count}文字まで使用できます" }
  validates :email, presence: true, uniqueness: true,
            length: { maximum: 255,
                      too_long: "は最大%{count}文字まで使用できます" },
            format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  before_save { email.downcase! }

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  has_many :favorites, dependent: :destroy
end
