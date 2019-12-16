class Hn < ApplicationRecord
  belongs_to :day
  
  def self.fetch_for(day)
    doc = Nokogiri::HTML(uri_get('https://news.ycombinator.com/').body)
    doc.css('a.storylink').each do |link|
      create!(title: link.text.to_s.strip, url: link.attr('href').to_s.strip, day_id: day.id)
    end
  end
end
