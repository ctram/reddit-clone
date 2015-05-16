# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  content          :text             not null
#  author_id        :integer          not null
#  commentable_id   :integer          not null
#  commentable_type :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  post_id          :integer          default(0), not null
#

class Comment < ActiveRecord::Base
  validates_presence_of :author_id, :commentable_id, :commentable_type, :content

  belongs_to :commentable, polymorphic: true

  belongs_to :author, class_name: 'User'

  has_many :comments, as: :commentable

  belongs_to :post
end
