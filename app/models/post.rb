# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string
#  content    :string
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
  validates :title, :author_id, presence: true
  # validate :has_at_least_one_sub
  has_many :comments, as: :commentable

  belongs_to(
    :author,
    class_name: 'User',
    foreign_key: :author_id,
    primary_key: :id
  )

  has_many(
    :post_subs,
    class_name: 'PostSub',
    foreign_key: :post_id,
    primary_key: :id

  )

  has_many(
    :subs,
    through: :post_subs,
    source: :sub
  )


  def has_at_least_one_sub
    if self.post_subs.nil?
      errors.add(:no_associated_subs, "A post must be linked to at least one sub!")
    end
  end
end
