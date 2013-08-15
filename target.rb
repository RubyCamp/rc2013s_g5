# coding: UTF-8

require 'dxruby'
require_relative 'lib/util'

class Target < Sprite
  attr_accessor :char, :is_answer

  # 初期化処理
  def initialize(char, ball_name="ball1", is_answer=false, difficulty=1)
  	@char = char
    @is_answer = is_answer
    @difficulty =difficulty
  	self.image = Util.load_image("#{ball_name}.png")
    font_size = 32
    font = Font.new(font_size)
    self.image.draw_font(
      (self.image.width / 2) - (font_size / 4),
      (self.image.height / 2) - (font_size / 2),
      @char.to_s,
      font,
      Util::Blue
    )
    @seikai = Sound.new("./music/kouka/quiz1.wav")  #正解音
    @hazure = Sound.new("./music/kouka/quiz2.wav")  #不正解音
    @hazure.set_volume(255)
  end

  def set_position(pos_x, pos_y)
    self.x = pos_x
    self.y = pos_y
  end


  #画面外処理
  def out_screen?
   self.y > 400
  end
  
  # 画面上の描画座標を更新する
  def update
    self.y += 1*@difficulty
  end

  def vanished?
    return @vanished
  end

  def hit(ima)
    @vanished = true
    @is_answer ? @seikai.play : @hazure.play
  end
end