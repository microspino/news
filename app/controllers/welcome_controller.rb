class WelcomeController < ApplicationController
  def index
    @day = Day.first
    @arr = []
    @arr += @day.arxivs.to_a
  end
end
