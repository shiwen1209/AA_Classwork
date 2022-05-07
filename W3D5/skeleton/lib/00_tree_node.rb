class PolyTreeNode

   attr_accessor :parent, :children, :value
   
   def initialize(value)
        @value = value 
        @children = []
        @parent = nil

   end 

   def parent=(node)

     
    if self.parent
      self.parent.children.delete(self)
    end
      
    unless  node == nil  || node.children.include?(self)

        node.children << self 

    end
    
      @parent = node    

   
   end

  def add_child(node)

     node.parent = self

     self.children << node  unless self.children.include?(node)

  end


 def remove_child(node)

    if self.children.include?(node)
        node.parent = nil
        self.children.delete(node)
    else

       raise "not a child!"
    
    end

 end

   def dfs(target)
      if target == self.value
         return self
      else
         self.children.each do |child|
            a = child.dfs(target)
            if a != nil 
               return a
            end 
         end
      end

      return nil 

   end


   def bfs(target)
      queue = [self]
      
      until queue.length == 0 
         a = queue.shift 
         if a.value == target 
            return a
         else
            queue += a.children 
         end
      end


   end

end


