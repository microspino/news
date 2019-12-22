class WelcomeController < ApplicationController
  def index
    @day = Day.first || Day.new(day: Date.today)
    
    @arxivs = @day.arxivs.shuffle
    @hns = @day.hns.shuffle
    @githubs = @day.gts.shuffle
  end
end
