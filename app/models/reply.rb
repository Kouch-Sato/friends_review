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

class Reply < ApplicationRecord
  belongs_to :review
end
