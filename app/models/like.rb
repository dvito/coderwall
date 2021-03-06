class Like < ActiveRecord::Base

  belongs_to :user
  belongs_to :likable, polymorphic: true, counter_cache: true

  validates :likable, presence: true
  validates :value, presence: true, numericality: { min: 1 }
  after_save :liked_callback

  scope :protips, where(likable_type: 'Protip')
  scope :protips_score, ->(protip_ids) { protips.where(likable_id: protip_ids).group(:likable_id).select('SUM(likes.value) as like_score') }

  def liked_callback
    likable.try(:liked, value)
  end
end

# == Schema Information
# Schema version: 20140713193201
#
# Table name: likes
#
#  id            :integer          not null, primary key
#  value         :integer
#  tracking_code :string(255)
#  user_id       :integer          indexed => [likable_id, likable_type]
#  likable_id    :integer          indexed => [likable_type, user_id]
#  likable_type  :string(255)      indexed => [likable_id, user_id]
#  created_at    :datetime
#  updated_at    :datetime
#  ip_address    :string(255)
#
# Indexes
#
#  index_likes_on_user_id  (likable_id,likable_type,user_id) UNIQUE
#
