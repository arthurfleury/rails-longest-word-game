require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10).map do
    ("A".."Z").to_a.sample(1)
    end
  end

  def exists_in_grid(response, grid)
    response.upcase.chars.all? do |letter|
      response.upcase.count(letter) <= grid.count(letter)
    end
  end

  def score
    @grid = params[:grid]
    @response = params[:name]
    user_serialized = open("https://wagon-dictionary.herokuapp.com/#{@response}").read
    hash_answer = JSON.parse(user_serialized)
    @score = 0
    if hash_answer["found"] == false
      @score = "Not an english word and your score is 0"
    elsif exists_in_grid(@response, @grid) == false
      @score = "Does not exist"
    elsif hash_answer.key?["error"]
      @score = "Not an english word and your score is 0"
    elsif hash_answer["found"] == true
      if hash_answer["length"] > 3
        @score += " 50 points, Your score is great"
      elsif hash_answer["length"] < 3
        @score += "20 points, Your score is good"
      end
    end
  end
end
