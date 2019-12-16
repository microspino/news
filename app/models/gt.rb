class Gt < ApplicationRecord
  belongs_to :day
  
  def self.fetch_for(day)
    doc = Nokogiri::HTML(uri_get('https://github.com/trending?spoken_language_code=en').body)
    doc.css('article').each do |article|
      title = "#{article.css('h1').text.to_s.strip.split('/')[-1].to_s.strip}: "
      article.children.select{|x| x.name=='p'}.each do |para|
        title += para.text.to_s.strip
      end
      create!(key: article.css('h1').css('a').first.attr('href').to_s.strip, title: title, day_id: day.id)
    end
  end
end
