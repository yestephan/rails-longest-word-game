require "open-uri"
require 'json'


class GamesController < ApplicationController
  def new
    letters_number = 8
    @letters = []

    letters_number.times do
      rand_nr = rand(0..25)
      @letters << ('A'..'Z').to_a[rand_nr]
    end
  end

  def score
    @letters = params[:letters]
    answer = params[:answer].upcase
    time_diff = (Time.current - Time.parse(params[:timestamp])).round
    @score = answer.length + (10 / time_diff).round

    # Check if word exists
    request_url = "https://wagon-dictionary.herokuapp.com/"
    request_query = answer
    url = "#{request_url}#{request_query}"
    word_exist = JSON.parse(URI.open(url).read)["found"]

    if word_exist
      # Check if each letter exists in the array
      answer_array = answer.split("")
      answer_array.each do |letter|
        if @letters.include?(letter)
          @response = "Congratulations, #{answer} is part of the array #{@letters}"
          next
        else
          @response = "Sorry #{answer} can't be built out of #{@letters}"
          @score = 0
          break
        end
      end
    else
      @response = "#{answer} is not a valid English word."
      @score = 0
    end



    # raise
    # binding.pry
  end
end
