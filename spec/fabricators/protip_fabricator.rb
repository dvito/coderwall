Fabricator(:protip) do
  topics ["Javascript", "CoffeeScript"]
  title { Faker::Company.catch_phrase }
  body { Faker::Lorem.sentences(8).join(' ') }
  user { Fabricate.build(:user) }
end

Fabricator(:link_protip, from: :protip) do
  body "http://www.google.com"
end

# == Schema Information
# Schema version: 20140713193201
#
# Table name: protips
#
#  id                  :integer          not null, primary key
#  public_id           :string(255)      indexed
#  kind                :string(255)
#  title               :string(255)
#  body                :text
#  user_id             :integer          indexed
#  created_at          :datetime
#  updated_at          :datetime
#  score               :float
#  created_by          :string(255)      default("self")
#  featured            :boolean          default(FALSE)
#  featured_at         :datetime
#  upvotes_value_cache :integer          default(0), not null
#  boost_factor        :float            default(1.0)
#  inappropriate       :integer          default(0)
#  likes_count         :integer          default(0)
#
# Indexes
#
#  index_protips_on_public_id  (public_id)
#  index_protips_on_user_id    (user_id)
#
