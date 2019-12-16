class Arxiv < ApplicationRecord
  belongs_to :day

  URLs = [
    'https://arxiv.org/list/cs.AI/recent',
    'https://arxiv.org/list/cs.CV/recent',
    'https://arxiv.org/list/cs.LG/recent',
    'https://arxiv.org/list/cs.RO/recent',
  ]

  def self.fetch_for(day)
    URLs.each do |url|
      doc = Nokogiri::HTML(uri_get(url).body)
      doc.css('dl').each do |dl|
        last = nil
        dl.children.each do |child|
          if child.name == 'dt'
            last = create!(key: child.css('a[title=Abstract]').text.to_s.strip.split('arXiv:')[-1].to_s.strip, day_id: day.id)
          elsif child.name == 'dd'
            last.update_attribute(:title, child.css('div.list-title').text.to_s.strip.split('Title: ')[-1].to_s.strip)
          end
        end
      end
    end
  end
end
