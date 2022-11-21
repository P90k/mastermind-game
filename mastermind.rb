# frozen_string_literal: true

class Mastermind
  def initialize
    @code_colors = %w[red blue yellow green black white]
    @key_pegs = %w[x x x x]
    @secret_code = build_secret_code
  end

  def build_secret_code
    secret_code = []

    until secret_code.length == 4
      random_color = @code_colors[rand(4)]
      secret_code.include?(random_color) ? next : secret_code.push(random_color)
    end
    secret_code
  end

  def secret_code
    puts @secret_code
  end

  def player_guess
    gets.chomp.split(',')
  end
end

class GameSession < Mastermind
end
mastermind = Mastermind.new
mastermind.secret_code
