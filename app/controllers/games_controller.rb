require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @letters_array = Array.new(10){[*"A".."Z"].sample}
  end

  def score
    letters_array = params[:letters].downcase.split("")
    @status_scr = true
    @status_dict = true
    @answer = params[:answer]
    answer_arr = @answer.split("")

    # Check if the letter belongs to the scrabbled letters
    answer_arr.each do |letter|
      if letters_array.include? letter
        letters_array.delete_at(letters_array.index(letter))
      else
        @status_scr = false
      end
    end

    # Check if the letter belongs to the dictionary
    response = JSON.parse(open("https://wagon-dictionary.herokuapp.com/#{@answer.downcase}").read)
    @status_dict = response["found"]

  end

end


# user_input.all? {|letter| user_input.count()}