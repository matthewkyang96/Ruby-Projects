class PolyTreeNode
    attr_reader :parent
    attr_accessor :value

    def initialize(value)
        @parent = nil
        @children = []
        @value = value
    end

    def inspect
        @value.inspect
        @children = []
        @parent = nil
    end

    def children
        @children
    end


    def parent=(new_parent)
        return if self.parent == new_parent

        #detaching from current parent
        if self.parent
            self.parent.children.delete(self)
        end

        #set new parent
        @parent = new_parent
        if self.parent.nil?  #return node if no parent
            return self
        else     
            self.parent.children << self unless self.parent.children.include?(self) #add node to its parent's children
        end
    end

    def add_child(node)
        node.parent = self
    end

    def remove_child(node)
        if !self.children.include?(node)
            node.parent = nil
            raise "not a valid child"
        else
            node.parent = nil
        end
    end

    def dfs(value)
        return self if self.value == value

        children.each do |child|
            search_res = child.dfs(value)
            return search_res unless search_res.nil?
        end

        nil
    end

    def bfs(value)
        queue = [self]

        until queue.empty?
            node = queue.shift
            if node.value == value
                return node
            else
                node.children.each{|child| queue << child}
            end
        end

        nil
        

    end

end