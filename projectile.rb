class Projectile
  attr_reader :starting_height, :starting_velocity, :angle
  def initialize(starting_height,starting_velocity,angle)
    @starting_height=starting_height
    @starting_velocity=starting_velocity
    @angle=angle
  end

  def height_eq
    @height_eq ||= "h(t) = -16.0t^2 + #{vy}t + #{starting_height}"
  end
  
  def horiz_eq
    @horiz_eq ||= "x(t) = #{vx}t"
  end
  
  def height(moment)
    (-16 * (moment)**2 + (vx * moment) + starting_height).round(3)
  end
  
  def horiz(moment)
    (vx * moment).round(3)
  end
  
  def landing
    @landing ||= [landing_x, landing_y, landing_time].map { |el| el.round(3) }
  end
  
  private

  def landing_time
    @landing_time ||= sol1.positive? ? sol1 : sol2
  end

  def landing_y
    height(landing_time)
  end

  def landing_x
    horiz(landing_time)
  end

  def vy
    @vy ||= (starting_velocity * Math.sin(angle * degrees)).round(3)
  end

  def vx
    @vx ||= (starting_velocity * Math.cos(angle * degrees)).round(3)
  end

  def degrees
    @degrees||=Math::PI/180
  end

  def sol1
    @sol1 ||= (-vy - root) / -32
  end

  def sol2
    (-vy + root) / -32
  end

  def root
    @root ||= Math.sqrt(discriminant)
  end

  def discriminant
    (vy**2)-(-64*starting_height)
  end
end

#p = Projectile.new(5, 2, 45)
#p p.height_eq
#p p.horiz_eq
#p p.height(0.2)
#p p.horiz(0.2)
#p p.landing

