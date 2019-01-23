require 'gosu'
require_relative 'snake'
require_relative 'food'

class Game < Gosu::Window
  HEIGHT = 24
  WIDTH = 32

  START_SPEED = 0.1

  def initialize
      @background_image = Gosu::Image.new("background.jpg", :tileable => true)

    super WIDTH * Snake::SIZE, HEIGHT * Snake::SIZE
    self.caption = "Snake"
    @last_move = Time.now
    reset_snake
    reset_food
  end

  def update
    set_snake_direction_from_keyboard
    return if (Time.now - @last_move) < @speed

    @snake.move
    @last_move = Time.now

    if still_in_bounds?
      eat if @snake.eat?(@food)
    else
      reset_snake
    end
  end

  def draw
    @background_image.draw(0, 0, 0)

    @snake.draw
    @food.draw
    font = Gosu::Font.new(20)
    font.draw_text(@snake.length - 1, WIDTH * (Snake::SIZE - 1), Snake::SIZE, 1, 1, 1, Gosu::Color::YELLOW)
  end

  private

  def reset_snake
    @snake = Snake.new
    @speed = START_SPEED
    sound("hertzel").play
  end

  def reset_food
    @food = Food.random(WIDTH, HEIGHT)
  end

  def set_snake_direction_from_keyboard
    if turn?(Gosu::KB_LEFT, "right")
      @snake.direction = "left"
    elsif turn?(Gosu::KB_RIGHT, "left")
      @snake.direction = "right"
    elsif turn?(Gosu::KB_UP, "bottom")
      @snake.direction = "top"
    elsif turn?(Gosu::KB_DOWN, "top")
      @snake.direction = "bottom"
    end
  end

  def turn?(button, opposite_direction)
    Gosu.button_down?(button) && @snake.direction != opposite_direction
  end

  def still_in_bounds?
    @snake.x >= 0 &&
      @snake.x < WIDTH * Snake::SIZE &&
      @snake.y >= 0 &&
      @snake.y < HEIGHT * Snake::SIZE
  end

  def eat
    reset_food
    @snake.length += 1
    sound("eat").play
    @speed = @speed * 0.95
  end

  def sound(type)
    Gosu::Sample.new File.join(__dir__, "#{type}.wav")
  end
end

Game.new.show
