class Micropost < ApplicationRecord
  belongs_to :user

  #バリデーション
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 140}

  #スコープ
  default_scope -> { order(created_at: :desc)}
end
