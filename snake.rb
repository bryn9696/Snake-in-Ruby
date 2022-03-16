require 'ruby2d'

set background: 'navy'
set fps_cap: 10

GRID_SIZE = 20
GRID_WIDTH = Window.width / GRID_SIZE
GRID_HEIGHT = Window.height / GRID_SIZE

class Snake
  attr_writer :direction

  def initialize
    @positions = [2, 0], [2, 1], [2, 2], [2, 3]
    @direction = 'down'
  end

  def draw
    @positions.each do |position|
      Square.new(x: position[0] * GRID_SIZE, y: position[1] * GRID_SIZE, size: GRID_SIZE - 1, color: 'white')
    end
  end

  def move
    @positions.shift
    case @direction 
    when 'down'
      @positions.push(new_coords(snake_head[0], snake_head[1] + 1))
    when 'up'
      @positions.push(new_coords(snake_head[0], snake_head[1] - 1))
    when 'left'
      @positions.push(new_coords(snake_head[0] - 1, snake_head[1]))
    when 'right'
      @positions.push(new_coords(snake_head[0] + 1, snake_head[1]))
    end
  end

  def can_change_direction?(new_direction)
    case @direction
      when 'up' then new_direction != 'down'
      when 'down' then new_direction != 'up'
      when 'left' then new_direction != 'right'
      when 'right' then new_direction != 'left'
    end
  end

  private

  def new_coords(x, y)
    [x % GRID_WIDTH, y % GRID_HEIGHT]
  end

  def snake_head
    @positions.last
  end
end

class Game
  def initialize
    @score = 0
    @food_x = rand(GRID_WIDTH)
    @food_y = rand(GRID_HEIGHT)
  end
end

snake = Snake.new
game = Game.new

update do
  clear
  snake.move
  snake.draw
end

on :key_down do |event|
  if ['up', 'down', 'left', 'right'].include?(event.key)
    if snake.can_change_direction?(event.key)
      snake.direction = event.key
    end
  end
end

show