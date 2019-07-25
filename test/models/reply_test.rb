# == Schema Information
#
# Table name: replies
#
#  id         :bigint           not null, primary key
#  review_id  :integer
#  content    :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class ReplyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
