class Arxiv < ApplicationRecord
  belongs_to :day

  URLs = [
    'https://arxiv.org/list/math/recent',
    'https://arxiv.org/list/cs.AI/recent',
    'https://arxiv.org/list/cs.CV/recent',
    'https://arxiv.org/list/cs.DS/recent',
    'https://arxiv.org/list/cs.DC/recent',
    'https://arxiv.org/list/cs.LG/recent',
    'https://arxiv.org/list/cs.MS/recent',
    'https://arxiv.org/list/cs.NE/recent',
    'https://arxiv.org/list/cs.PL/recent',
    'https://arxiv.org/list/cs.RO/recent',
    'https://arxiv.org/list/cs.SE/recent',
    'https://arxiv.org/list/cs.SC/recent',
    'https://arxiv.org/list/stat/recent',
  ]

  def self.fetch_for(day)
    URLs.each do |url|
      doc = Nokogiri::HTML(uri_get(url).body)
      doc.css('dl').each do |dl|
        last = nil
        dl.children.each do |child|
          if child.name == 'dt'
            key = child.css('a[title=Abstract]').text.to_s.strip.split('arXiv:')[-1].to_s.strip
            last = where(key: key).first
            last = create!(key: key, day_id: day.id) if last.nil?
          elsif child.name == 'dd'
            last.update_attribute(:title, child.css('div.list-title').text.to_s.strip.split('Title: ')[-1].to_s.strip)
            last.update_attribute(:day_id, day.id)
          end
        end
      end
    end
  end
end
