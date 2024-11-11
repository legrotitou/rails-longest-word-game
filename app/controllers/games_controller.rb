require 'open-uri'
class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
    @letters.to_a
  end
  def score
    @letters = params[:letters].split(" ")
    @answer = params[:answer].upcase

    if @answer
      if included?(@answer, @letters)
        @included = true
        if english_word?(@answer)
          @english_word = true
        end
      end
    end
  end

    private

  def english_word?(answer)
    url = "https://dictionary.lewagon.com/#{answer}"
    response = JSON.parse(URI.parse(url).read)
    response["found"]
  end

  def included?(answer, letters)
    answer.chars.all? do |character|
      answer.count(character) <= letters.count(character)
    end
  end
  end
