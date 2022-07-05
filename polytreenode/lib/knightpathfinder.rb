require_relative "polytreenode"
require 'byebug'
class KnightPathFinder
    attr_reader :start_pos
    attr_accessor :root_node

    def initialize(start_pos)
        @start_pos = start_pos
        @considered_positions = [start_pos]
        build_move_tree
    end


    def self.valid_moves(pos)
        #possible knight moves
        valid_moves =[]
        moves = [
            [2,1],
            [2,-1],
            [-2,1],
            [-2,-1],
            [1,2],
            [-1,2],
            [1,-2],
            [-1,-2]
        ]
        cur_x , cur_y = pos
        moves.each do |(dx,dy)|
            new_pos = [cur_x + dx,cur_y + dy]
            if new_pos.all? {|coord| coord.between?(0,7)}
                valid_moves << new_pos
            end
        end
        valid_moves

    end

    def new_move_positions(pos)
        new_moves = KnightPathFinder.valid_moves(pos)
        new_moves.select!{|move| !@considered_positions.include?(move)}
        @considered_positions += new_moves
        new_moves
    end

    def build_move_tree
        self.root_node = PolyTreeNode.new(start_pos)
        nodes = [root_node]

        until nodes.empty?
                cur_node = nodes.shift
                cur_pos = cur_node.value

                new_move_positions(cur_pos).each do |next_pos|
                    next_node = PolyTreeNode.new(next_pos)
                    cur_node.add_child(next_node)
                    nodes << next_node
                end
        end
    end

    def find_path(end_pos)
        trace_path_back(root_node.dfs(end_pos))
    end

    def trace_path_back(node)
        path = []
        current_node = node
        until current_node.nil?
            path << current_node.value
            current_node = current_node.parent
        end
        path.reverse
    end

end

kpf = KnightPathFinder.new([0, 0])
p kpf.find_path([6, 2])