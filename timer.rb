# coding: UTF-8

require 'dxruby'

class Timer
  attr_accessor :limit
  FPS = 60
  def initialize sec
    # タイマー(5秒)
    @font=Font.new(32)
    @count = FPS * sec
  end

  def stop?
    @count<=0
  end

  def update
    @count -= 1
    @limit = @count / 60
  end

  def draw
    Window.drawFont(25,25,@limit.to_s,@font,{:color => [0,0,0]})
  end
end
