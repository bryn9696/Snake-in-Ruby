require 'ruby2d'

set background: 'navy'
set fps_cap: 10

GRID_SIZE = 20
class Snake
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
      @positions.push([snake_head[0], snake_head[1] + 1])
    end
  end

  private

  def snake_head
    @positions.last
  end
end

snake = Snake.new


update do
  clear
  snake.move
  snake.draw
end

show