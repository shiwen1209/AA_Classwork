require_relative "../skeleton/lib/00_tree_node.rb"

class KnightPathFinder

    attr_reader :root_node
    def initialize(start_pos)
        @start_pos = start_pos
        @root_node = PolyTreeNode.new(start_pos)
        @considered_positions = []
        
    end

    def self.valid_moves(pos)
        i, j = pos
        a = [i-2, j+1]
        b = [i-1, j+2]
        c = [i+1, j+2]
        d = [i+2, j+1]
        e = [i+2, j-1]
        f = [i+1, j-2]
        g = [i-1, j-2]
        h = [i-2, j-1]
        arr = [a,b,c,d,e,f,g,h]

        valid_moves = arr.select {|p| (0...8).include?(p[0]) && (0...8).include?(p[1])}
        return valid_moves
    end

    def new_move_positions(pos)
       newPosition = []
       valid_moves = KnightPathFinder.valid_moves(pos)
       valid_moves.each do |el| 
            if @considered_positions.include?(el) == false
                @considered_positions << el
                newPosition << el
            end
        end
        return newPosition
    end
  
  
    def build_move_tree

        queue = [@root_node]
        
        until queue.length == 0 
            parent = queue.shift 
            parentPos = parent.value
            new_move_positions(parentPos).each do |childPos|
                child = PolyTreeNode.new(childPos)
                parent.add_child(child)
                queue << child
            end
        end

    end

    def track_path(target_pos) 
        queue = [@root_node]
        until queue.length == 0 
            node = queue.shift 
            if node.value == target_pos
                return node
            else
                queue += node.children
            end 
        end
    end

    def find_path(target_pos)
        target_node = track_path(target_pos)
        return helper(target_node)
        # node = track_path(target_pos)
        # path = []
        # until node == nil
        #     path.unshift(node.value)
        #     node = node.parent
        # end
        # return path
    end

    def helper(node)
        return [] if node == nil 
        prev = helper(node.parent)
        return prev<< node.value 
    end

    
end