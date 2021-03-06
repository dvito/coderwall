Fabricator(:comment) do
  body { 'Lorem Ipsum is simply dummy text...' }
  commentable { Fabricate.build(:protip) }
  user { Fabricate.build(:user) }
end

# == Schema Information
# Schema version: 20140713193201
#
# Table name: comments
#
#  id                :integer          not null, primary key
#  title             :string(50)       default("")
#  comment           :text             default("")
#  commentable_id    :integer          indexed
#  commentable_type  :string(255)      indexed
#  user_id           :integer          indexed
#  likes_cache       :integer          default(0)
#  likes_value_cache :integer          default(0)
#  created_at        :datetime
#  updated_at        :datetime
#  likes_count       :integer          default(0)
#
# Indexes
#
#  index_comments_on_commentable_id    (commentable_id)
#  index_comments_on_commentable_type  (commentable_type)
#  index_comments_on_user_id           (user_id)
#
