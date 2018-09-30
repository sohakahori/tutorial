class Micropost < ApplicationRecord
  belongs_to :user

  # 画像アップローダー紐付け
  mount_uploader :picture, PictureUploader

  #バリデーション
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 140}
  validate :picture_size

  #スコープ
  default_scope -> { order(created_at: :desc)}

  def picture_size
    # Todo: 処理がかなり重くなるためコメントアウト
    # if picture_size > 5.megabytes
    #   errors.add(:picture, "should be less than 5MB")
    # end
  end
end
