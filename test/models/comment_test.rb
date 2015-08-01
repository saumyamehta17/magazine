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

require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
