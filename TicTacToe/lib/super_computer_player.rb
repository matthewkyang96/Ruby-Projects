require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    ttt_node = TicTacToeNode.new(game.board,mark)
    ttt_node.children.each do |node|
      if node.winning_node?(mark)
        return node.prev_move_pos
      end
    end

    ttt_node.children.each do |node|
      if !node.losing_node?(mark)
        return node.prev_move_pos
      end
    end

    raise "no non-losing nodes"

      


  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Matt")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end

