require "open-uri"

class GamesController < ApplicationController

  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @response = params[:word].upcase
    @letters = params[:letters].split
    @included = included?(@response, @letters)
    @english_word = english_word?(@response)
  end

  private

  def included?(words, letters)
    words.chars.all? { |letter| words.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = URI.open("https://dictionary.lewagon.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
