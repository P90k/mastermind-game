# frozen_string_literal: true

class Mastermind
  attr_accessor :secret_code

  def initialize
    @code_colors = %w[red blue yellow green black white]
    @feedback = %w[secret secret secret secret]
    @secret_code = generate_code
  end

  # Methods that relates to game mode codebreaker

  def generate_code
    secret_code = []

    until secret_code.length == 4
      random_color = @code_colors[rand(6)]
      secret_code.include?(random_color) ? next : secret_code.push(random_color)
    end
    secret_code
  end

  def set_secret_code
    puts 'Choose your secret code, four colors with a space between each color.'
    puts "Colors to choose from: red, blue, yellow, green, black, white\n\n"
    @secret_code = gets.chomp.split(' ')
    @secret_code
  end

  def player_guess
    puts "\nPlace your guess\n\n"
    gets.chomp.split(' ')
  end

  def feedback(guess)
    guess.each_with_index do |element, index|
      @feedback[index] = if @secret_code.include?(element) && @secret_code.index(element) == index
                           'black'
                         elsif @secret_code.include?(element)
                           'white'
                         else
                           'secret'
                         end
    end
    @feedback
  end

  # Methods that relate to game mode codemaker

  def computer_guess(feedback = [], previous_guess = [])
    return generate_code if previous_guess.length.zero? && feedback.length.zero?

    @possible_colors = [] # we need to store white colors somewhere.

    feedback.each_with_index do |element, index|
      if element == 'white'
        if @possible_colors.empty?
          @possible_colors.push(previous_guess[index])
          previous_guess[index] = @code_colors.sample
        else
          previous_guess[index] = @possible_colors[0]
          @possible_colors.delete_at(0)
        end
      elsif element == 'x'
        previous_guess[index] = if @possible_colors.empty?
                                  @code_colors.sample
                                else
                                  @possible_colors[0]
                                  @possible_colors.delete_at(0)
                                end
      else # element == 'black'
        @code_colors.delete(element) # assuming the rule is to only use one color per slot.
      end
    end
    previous_guess 
  end
end

class GameSession < Mastermind
  def initialize
    @game_session = super
    @feedback = []
  end

  def welcome_message
    "\nWelcome to MasterMind!"
  end

  def winners_message
    puts "\nCongratulations, you cracked the code!\n\n"
  end

  def losers_message
    "\nSorry you didn't win this time, better luck next time bro!\n\n"
  end

  def gameflow_codebreaker
    1.upto(12) do
      guess = player_guess
      puts "\nYour guess:     #{guess.join('  |  ')}"
      return winners_message if feedback(guess).count('black') == 4

      puts "\nFeedback:    #{feedback(guess).join('  |  ')}\n\n"
    end
    losers_message
  end

  def gameflow_codemaker
    set_secret_code
    feedback = []
    guess = []
    1.upto(12) do
      guess = computer_guess(feedback, guess)
      p guess
      puts 'Enter feedback'
      feedback = gets.chomp.split(' ')
      return winners_message if feedback.count('black') == 4
    end
    losers_message
  end

  def game_start
    puts welcome_message
    puts "\nDo you want to be codemaker or codebreaker?"
    choice = gets.chomp
    return gameflow_codemaker unless choice.downcase == 'codebreaker'

    gameflow_codebreaker
  end
end

GameSession.new.gameflow_codemaker
