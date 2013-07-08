# == Schema Information
#
# Table name: students
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  tagline           :string(255)
#  bio               :text
#  treehouse_profile :string(255)
#  linkedin          :string(255)
#  twitter           :string(255)
#  github            :string(255)
#  quote             :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
