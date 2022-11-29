# frozen_string_literal: true

class Mastermind
  def initialize
    @code_colors = %w[red blue yellow green black white]
    @feedback = %w[x x x x]
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
    puts @secret_code
  end

  def player_guess
    gets.chomp.split(' ')
  end

  def feedback(user_guess)
    user_guess.each_with_index do |element, index|
      if @secret_code.include?(element) && @secret_code.index(element) == index
        @feedback[index] = 'black'
      elsif @secret_code.include?(element)
        @feedback[index] = 'white'
      else
        next
      end
    end
    @feedback
  end
end

class GameSession < Mastermind
  def initialize
    @game_session = super
  end
end

mastermind = Mastermind.new
p mastermind.secret_code
p mastermind.feedback(%w[red green yellow blue])
