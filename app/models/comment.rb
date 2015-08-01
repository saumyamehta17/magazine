# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  desc       :text
#  article_id :integer
#  user_id    :integer
#  ancestry   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Comment < ActiveRecord::Base
  belongs_to :article
  belongs_to :user
  has_ancestry
end
