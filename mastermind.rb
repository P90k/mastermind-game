# frozen_string_literal: true

class Mastermind
  def initialize
    @code_colors = %w[red blue yellow green black white]
    @feedback = %w[- - - -]
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

  def secret_code
    p @secret_code
  end

  def player_guess
    p 'Place your guess'
    gets.chomp.split(' ')
  end

  def feedback(user_guess)
    user_guess.each_with_index do |element, index|
      @feedback[index] = if @secret_code.include?(element) && @secret_code.index(element) == index
                           'black'
                         elsif @secret_code.include?(element)
                           'white'
                         else
                           '-'
                         end
    end
    @feedback
  end

  def determine_end(count)
    count + 1 > 12
  end
end

class GameSession < Mastermind
  def initialize
    @game_session = super
  end

  def game_session
    rounds = 0
    p 'Welcome to MasterMind, can you crack the code?'
    puts ''
    until determine_end(rounds)
      guess = player_guess
      puts "Your guess: #{guess}"
      puts ''
      puts "Feedback on your guess: #{feedback(guess)}"
      rounds += 1
      if feedback(guess).count('black') == 4
        p 'Congratulations, you cracked the code!'
        break
      end
    end
  end
end

gamesession = GameSession.new
gamesession.game_session
