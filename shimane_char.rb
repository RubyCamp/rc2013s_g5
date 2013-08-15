# coding: UTF-8

require 'dxruby'
require_relative 'lib/util'

class ShimaneChar < Sprite
  attr_accessor :char, :pos

  # 初期化処理
  def initialize(char)
  	@char = char
  	self.image = Util.load_image("ball2.png")

    font_size = 32
    font = Font.new(font_size)
    self.image.draw_font(
      (self.image.width / 2) - (font_size / 4),
      (self.image.height / 2) - (font_size / 2),
      @char.to_s,
      font,
      Util::Blue
    )
  end

  # 画面上の描画座標を更新する
  def update
    self.y += 1
  end
end