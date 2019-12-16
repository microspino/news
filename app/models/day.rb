class Day < ApplicationRecord
  has_many :arxivs
  has_many :hns
  has_many :gts

  def self.fetch!
    latest = nil
    if Date.today.sunday? || Date.today.monday?
      latest = first
      latest.update_attribute(:day, Date.today)
    else
      # 2 3 4 5 6
      ActiveRecord::Base.connection.execute('TRUNCATE TABLE days RESTART IDENTITY;')
      ActiveRecord::Base.connection.execute('TRUNCATE TABLE arxivs RESTART IDENTITY;')
      ActiveRecord::Base.connection.execute('TRUNCATE TABLE hns RESTART IDENTITY;')
      ActiveRecord::Base.connection.execute('TRUNCATE TABLE gts RESTART IDENTITY;')
      latest = create!(day: Date.today)
    end
    latest.fetch!
  end
  
  def fetch!
    Arxiv.fetch_for(self)
    Hn.fetch_for(self)
    Gt.fetch_for(self)
  end
end
