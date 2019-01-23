class Snake
  SIZE = 20

  attr_reader :x, :y
  attr_accessor :length, :direction

  def initialize
    @image = Gosu::Image.new("dr.png")
    @x = @y = @vel_x = @vel_y = @angle = 0.0
    @tail_image = Gosu::Image.new("hummus.png")

    @x = 0
    @y = 0
    @tail = []
    @length = 1
    @direction = "right"
  end

  def move
    @tail.unshift([@x, @y]) # move current position to head of tail.
    @tail.pop if @tail.size == @length # Drop queue of tail unless recently grown

    case @direction
    when "right" then @x += SIZE
    when "left" then @x -= SIZE
    when "bottom" then @y += SIZE
    when "top" then @y -= SIZE
    end
  end

  def eat?(food)
    @x == food.x && @y == food.y
  end

  def draw
        @image.draw_rot(@x, @y, 1, @angle)

  @tail.each do |tail|
      Gosu.draw_rect(tail.first, tail.last, SIZE, SIZE, [Gosu::Color::WHITE, Gosu::Color::BLUE].sample)
         end
  end
end
