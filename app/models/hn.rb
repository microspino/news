class Hn < ApplicationRecord
  belongs_to :day
  
  def self.fetch_for(day)
    doc = Nokogiri::HTML(uri_get('https://news.ycombinator.com/').body)
    doc.css('a.storylink').each do |link|
      url = link.attr('href').to_s.strip
      last = where(url: url).first
      last = create!(url: url, day_id: day.id) if last.nil?
      last.update_attribute(:title, link.text.to_s.strip)
      last.update_attribute(:day_id, day.id)
    end
  end
end
