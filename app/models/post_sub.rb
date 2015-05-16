# == Schema Information
#
# Table name: post_subs
#
#  id         :integer          not null, primary key
#  post_id    :integer          not null
#  sub_id     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

#validates uniqueness of post_id in scope fo sub_id
class PostSub < ActiveRecord::Base
  validates_presence_of :post_id, :sub_id
  validates :sub_id, uniqueness: { scope: :post_id }
  belongs_to :post
  belongs_to :sub


end
