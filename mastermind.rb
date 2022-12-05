# frozen_string_literal: true

class Mastermind
  attr_accessor :secret_code
  def initialize
    @code_colors = %w[red blue yellow green black white]
    @feedback = %w[secret secret secret secret]
    @secret_code = generate_secret_code
  end

  def generate_secret_code
    secret_code = []

    until secret_code.length == 4
      random_color = @code_colors[rand(6)]
      secret_code.include?(random_color) ? next : secret_code.push(random_color)
    end
    secret_code
  end

  def change_secret_code
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
end

class GameSession < Mastermind
  def initialize
    @game_session = super
  end

  def welcome_message
    "\nWelcome to MasterMind!"
  end

  def winners_message
    "\nCongratulations, you cracked the code!\n\n"
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

  def game_start
    puts welcome_message
    puts "\nDo you want to be codemaker or codebreaker?"
    choice = gets.chomp
    return unless choice.downcase == 'codebreaker'

    puts gameflow_codebreaker
  end
end

gamesession = GameSession.new
gamesession.change_secret_code
p gamesession.secret_code