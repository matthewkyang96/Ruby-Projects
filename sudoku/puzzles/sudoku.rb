require_relative "board"
require "byebug"

class SudokuGame
  def self.from_file(filename)
    board = Board.from_file(filename)
    self.new(board)
  end

  def initialize(board)
    @board = board
  end

  def get_pos
    pos = nil
    until pos && valid_pos?(pos)
        puts "Please enter a position on the board (e.g., '3,4')"
        print "> "
        pos = parse_pos(gets.chomp)
    end
    pos
  end

  def parse_pos(string)
    string.split(",").map do |char|
        Integer(char)
        rescue
    end
  end

  def get_val
    val = nil
    until val && valid_val?(val)
        puts "Please enter a value between 1 and 9 (0 to clear the tile)"
        print "> "
        val = gets.chomp.to_i
    end
    val
  end

  def valid_pos?(pos)
    pos.is_a?(Array) && 
    pos.length == 2 && 
    pos.all?{|coord| coord.between?(0, board.size - 1) }
  end

  def valid_val?(val)
    val.is_a?(Integer) &&
    val.between?(0,9)
  end

  def play_turn
    board.render
    pos = get_pos
    val = get_val
    board[pos] = val
  end

  def run
    play_turn until solved?
    board.render
    puts "Congrats"
  end

  def solved?
    board.solved?
  end

  private

  attr_reader :board


end


x = SudokuGame.from_file("sudoku1_almost.txt")


