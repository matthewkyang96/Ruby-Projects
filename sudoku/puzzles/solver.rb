require_relative "board"

class Solver
    attr_reader :guessing_tiles
    
    def self.from_file(filename)
        board = Board.from_file(filename)
        self.new(board)

    end

    def initialize(board)
        @board = board
        @guessing_tiles = []
    end


    def possible?(x, y, val)
        #Check rows
        (0...9).each do |i|
            return false if board[[i,y]].value == val
        end

        #Check columns
        (0...9).each do |i|
            return false if board[[x,i]].value == val
        end

        #check squares
        x_0 = (x / 3) * 3
        y_0 = (y / 3) * 3

        (x_0...x_0 + 3).each do |i|
            (y_0...y_0 + 3).each do |j|
                return false if board[[i,j]].value == val
            end
        end

        return true
    end   

    def dfs
        (0...9).each do |i|
            (0...9).each do |j|
                if board[[i,j]] == 0
                    (1..9).each do |val|
                        if possible?(i,j,val)
                            board[[i,j]] = val
                            dfs
                            board[[i,j]] = 0
                        end
                    end
                    return
                end
            end
        end
        board.render
    end

    def render
        board.render
    end


    attr_reader :board
end

x = Solver.from_file("sudoku1.txt")
x.render
x.dfs
p x.board[[0,0]].value
