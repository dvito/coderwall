require 'spec_helper'

RSpec.describe Comment, :type => :model do
  let(:comment) { Fabricate(:comment) }

  describe '#spam_report' do
    subject { super().spam_report }
    it { is_expected.to be_nil }
  end

  context 'counter_cache' do

    it 'should update count' do

      expect(comment.likes_count).to be_zero
      #Random tests
      rand(2..10).times do
        comment.likes.create(user: Fabricate(:user))
      end
      expect(comment.likes_count).to eq(comment.likes.count)
      comment.likes.last.destroy
      expect(comment.likes_count).to eq(comment.likes.count)
    end

  end
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
