class Day < ApplicationRecord
  has_many :arxivs
  has_many :hns
  has_many :gts
end
