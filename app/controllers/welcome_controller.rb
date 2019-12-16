class WelcomeController < ApplicationController
  def index
    @day = Day.first
    @arr = []
    @arr += @day.arxivs.to_a
    @arr += @day.hns.to_a
  end
end
