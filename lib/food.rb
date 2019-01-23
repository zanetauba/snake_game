# rubocop:disable Naming/UncommunicativeMethodParamName


class Food
  attr_reader :x, :y

  def initialize(x, y)
    @foods = ["bamba.png", "beer.png", "falafel.png", "jachnun.png", "pita.png", "shakshuka.png", "vine-leaves.png"].sample
    @image1 = Gosu::Image.new(@foods)
    @x = @y = @vel_x = @vel_y = @angle = 0.0
    @x = x
    @y = y
  end

  def draw
        @image1.draw_rot(@x, @y, 1, @angle)
  end

  def self.random(width, height)
    x = (0...width).to_a.sample * Snake::SIZE
    y = (0...height).to_a.sample * Snake::SIZE

    Food.new(x, y)
  end
end
