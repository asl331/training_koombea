class RectangleTriangles

  def count_rect_triang(points)
    calculate_sides(points.uniq)
  end

  
  private
  def calculate_sides(points)  
    get_triangules(points).count do |e|
      sides = 3.times
               .map { |i| distance_points(e[i], e[i+1 > 2 ? 0 : i+1]) }
               .sort!
      
      sides[2].round(3) == Math.hypot(sides[0], sides[1]).round(3)
      # if sides[2] == Math.hypot(sides[0], sides[1])
      #   p "------------------"
      #   p sides
      #   true
      # else
      #   false
      # end
    end
  end

  def get_triangules(points)
    points.combination(3).to_a
  end

  def distance_points(a, b)
    Math.hypot((b[0]-a[0]), (b[1]-a[1]))
  end 
end
