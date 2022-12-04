# frozen_string_literal: true

class Mastermind
  def initialize
    @code_colors = %w[red blue yellow green black white]
    @feedback = %w[secret secret secret secret]
    @secret_code = build_secret_code
  end

  def build_secret_code
    secret_code = []

    until secret_code.length == 4
      random_color = @code_colors[rand(6)]
      secret_code.include?(random_color) ? next : secret_code.push(random_color)
    end
    secret_code
  end

  def player_guess
    puts "\nPlace your guess\n\n"
    gets.chomp.split(' ')
  end

  def feedback(user_guess)
    user_guess.each_with_index do |element, index|
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
    "\nWelcome to MasterMind, can you crack the code?"
  end

  def winners_message
    "\nCongratulations, you cracked the code!\n\n"
  end

  def losers_message
    "\nSorry you didn't win this time, better luck next time bro!\n\n"
  end

  def game_loop
    1.upto(12) do
      guess = player_guess
      puts "\nYour guess:     #{guess.join('  |  ')}"
      return winners_message if feedback(guess).count('black') == 4

      puts "\nFeedback:    #{feedback(guess).join('  |  ')}\n\n"
    end
    losers_message
  end

  def game_flow
    puts welcome_message
    puts game_loop
  end
end

gamesession = GameSession.new
gamesession.game_flow
