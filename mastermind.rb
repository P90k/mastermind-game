# frozen_string_literal: true

class MasterMind
  attr_accessor :possible_colors

  def initialize
    @possible_colors = %w[red blue yellow green black white]
    @secret_code = generate_code
  end

  def winners_message
    puts "\nCongratulations, you cracked the code!\n\n"
  end

  def winners_message_pc
    puts "\n Congratulations computer, you broke the code!"
  end

  def losers_message
    "\nSorry you didn't win this time, better luck next time bro!\n\n"
  end

  def generate_code
    @possible_colors.sample(4)
  end
end

class CodeMaker < MasterMind
  def initialize
    @possible_colors = %w[red blue yellow green black white]
    @white_keypegs = []
    @black_keypegs = %w[x x x x]
  end

  def set_secret_code
    puts 'Choose your secret code, four colors with a space between each color.'
    puts "Colors to choose from: red, blue, yellow, green, black, white\n\n"
    @secret_code = gets.chomp.split(' ')
    @secret_code
  end

  def computer_guess(feedback = [], previous_guess = [])
    return @possible_colors.sample(4) if previous_guess.length.zero?

    previous_guess.each { |color| @possible_colors.delete(color) }
    feedback.each_with_index do |key_peg, index|
      previous_guess[index] = @possible_colors.sample if key_peg == 'x'
      @black_keypegs[index] = previous_guess[index] if key_peg == 'black'
    end
    return @black_keypegs if @black_keypegs.count('x').zero?

    previous_guess.shuffle
  end

  def gameflow
    set_secret_code
    feedback = []
    guess = []
    1.upto(12) do
      feedback.count('black') == 4 ? winners_message_pc : guess = computer_guess(feedback, guess)
      p guess
      puts 'Enter feedback'
      feedback = gets.chomp.split(' ')
    end
    puts losers_message
  end
end

class CodeBreaker < MasterMind
  def initialize
    @possible_colors = %w[red blue yellow green black white]
    @secret_code = generate_code
  end

  def player_guess
    puts "\nPlace your guess\n\n"
    gets.chomp.split(' ')
  end

  def feedback(guess)
    feedback = []
    guess.each_with_index do |element, index|
      feedback[index] = if @secret_code.include?(element) && @secret_code.index(element) == index
                          'black'
                        elsif @secret_code.include?(element)
                          'white'
                        else
                          'secret'
                        end
    end
    feedback
  end

  def gameflow
    1.upto(12) do
      guess = player_guess
      puts "\nYour guess:     #{guess.join('  |  ')}"
      return winners_message if feedback(guess).count('black') == 4

      puts "\nFeedback:    #{feedback(guess).join('  |  ')}\n\n"
    end
    puts losers_message
  end
end

class GameSession
  def initialize
    @game_session = MasterMind.new
    @feedback = []
  end

  # communication to user

  def welcome_message
    "\nWelcome to MasterMind!"
  end

  def game_start
    puts welcome_message
    puts "\nDo you want to be codemaker or codebreaker?"
    choice = gets.chomp
    choice.downcase == 'codemaker' ? CodeMaker.new.gameflow : CodeBreaker.new.gameflow
  end
end

GameSession.new.game_start
