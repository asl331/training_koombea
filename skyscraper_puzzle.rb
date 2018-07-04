class SkyscraperPuzzle
 
  @puzzle=Array.new
  @side=0
  @array_clues_couples
 

  def solve_puzzle(clues)

   get_possible_solutions(clues)
   @array_clues_couples
   search_solutions(get_possible_solutions(clues))
   @puzzle
  end

  def search_solutions(possible_solutions)
    @array_clues_couples.each_with_index do |e,eindex|
      possible_solutions.values_at(e).flatten(1).each_with_index do |val,valindex| 
        if is_valid_skyscr_conf(val,eindex)
          insert_skysc(val,eindex)
          break
        end
       end
     end
   end

   def insert_skysc(skyscr_conf,pos)
    pos_vert=(@side-pos).abs
    skyscr_conf.each_with_index do|e,eindex|
      if pos<=@side-1
        @puzzle[eindex][pos]=e.to_i
        else
        @puzzle[pos_vert][eindex]=e.to_i
      end 
    end
  end

  def get_possible_solutions(clues)
    @puzzle=[[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]
    @side=clues.length/4
    hash_conf_skyscr = Hash.new
    hash_tree = Hash.new { |hash, key| hash_tree[key] = [] }
    hash_conf_skyscr=get_skyscr_config
    
    @array_clues_couples=get_clues_couples(clues)
    @array_clues_couples.each do|e|
    array_tmp=Array.new
    array_skyscrapers=Array.new
    if e[0]==0 && e[1]!=0 && !hash_tree.key?([0,e[1]])
        hash_conf_skyscr.select {|k,v| k[1]==e[1]}.each do |key,values|
          array_tmp.push(values)   
        end
      array_tmp= array_tmp.flatten(1)

      array_tmp.each do |val|
        array_skyscrapers<<[[0,e[1]],val]
      end
      array_skyscrapers.each { |x,y| hash_tree[x] << y }
    end

       if   e[0]!=0 &&  e[1]==0  && !hash_tree.key?([e[0],0])
          hash_conf_skyscr.select {|k,v| k[0]==e[0]}.each do |key,values|
            array_tmp.push(values)   
          end
          array_tmp= array_tmp.flatten(1)

          array_tmp.each do |val|
            array_skyscrapers<<[[e[0],0],val]
          end
          array_skyscrapers.each { |x,y| hash_tree[x] << y }
       end
     
       if e[1]!=0 && e[0]!=0 

        array_tmp=hash_conf_skyscr.values_at(e)
        array_tmp= array_tmp.flatten(1)

        array_tmp.each do |val|
         array_skyscrapers<<[e,val]
        end
      
       array_skyscrapers.each { |x,y| hash_tree[x] << y }
       
      end
    
    end

    return hash_tree
  end

  def get_skyscr_config
    skyscr_conf=[*1..4].permutation.to_a

    #
    max=skyscr_conf.to_a.first.max
    size=skyscr_conf.to_a.first.length
    hash_conf_clues = Hash.new { |hash, key| hash_conf_clues[key] = [] }
    array_conf_clues=Array.new
    change=0
    skyscr_conf.each do |e|
      change=nil
      clue1=1
      clue2=1
      e.each_with_index do |f,index|
        break if index==size-1
        change||=f==max
        if e[0]==max && e[size-1]==max-1
          clue2+=1
          break
        end
        if e[size-1]==max && e[0]==max-1
          clue1+=1
          break
        end
      
        if !change
          if f<e[index+1]
            clue1+=1
          end
        end
      
        if change 
          if f>e[index+1]
            clue2+=1
          end
        end
      end
      array_conf_clues<<[[clue1,clue2],e] 
    end

    array_conf_clues.each { |x,y| hash_conf_clues[x] << y }

  return hash_conf_clues
  end

  def get_clues_couples(clues)
    size=clues.length
    init_index=((size/4)*3)-1
    index_clue_couple=init_index

    control_couple=size/4
    count=0
    array_clues=Array.new

    clues.each_with_index do |f,index|
      count+=1
      array_clues<<[clues[index],clues[index+index_clue_couple]]
      break if index+1==size/2
      index_clue_couple-=2
      if count==control_couple
        index_clue_couple=init_index
        count=0
      end
    end
    return array_clues
  end


  def is_valid_skyscr_conf(skyscr_conf,pos)
    pos_vert=(@side-pos).abs

   
    skyscr_conf.each_with_index do|e,eindex|

      if pos<=@side-1
        if e!= @puzzle[eindex][pos]
          @puzzle.each_with_index do|f,pindex|   
            next if pindex==pos
            if e==@puzzle[eindex][pindex]
              return false 
            end
          end
          return false if @puzzle[eindex][pos]!=0 
        end
       else
          if e!= @puzzle[pos_vert][eindex]

            @puzzle.each_with_index do|f,pindex|
              next if pindex==pos_vert
              if e==@puzzle[pindex][eindex]
                return false
              end           
            end
            return false if @puzzle[pos_vert][eindex]!=0
          end   
        end
     end
     return true
  end
end

