class Blog < ApplicationRecord
  validates :title, :content, presence: true,
            length:{ maximum: 140,
                    too_long: "は最大%{count}文字まで使用できます"}

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user


end
