# Games controller
require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @letters = generate_letters(10)
  end

  def score
    @word  = params[:word].upcase
    @letters = params[:letters].split
    @included = included?(@word, @letters)
    @english = english_word?(@word)
  end

  private

  def generate_letters(grid_size)
    Array.new(grid_size) { ('A'..'Z').to_a.sample }
  end

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
