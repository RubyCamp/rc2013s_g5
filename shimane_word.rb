# coding: Shift_JIS

require 'dxruby'
require_relative 'lib/util'
require_relative 'shimane_char'

class ShimaneWord < Sprite
  BASE_X = 50    # ピース群描画位置のX座標オフセット
  BASE_Y = 50    # ピース群描画位置のY座標オフセット

  attr_accessor :string, :answer

  # 初期化処理
  def initialize(string)
  	@string = string
  	@shimane_chars = []
  	@answer = ''
  	hide_char
  	generate_shimane_char
  end

  def hide_char
  	key = rand(@string.length)
  	@answer = @string[key]
  	@string[key] = '?'
  end

  def generate_shimane_char
	@string.split('').each_with_index{|char, index|
  		shimane_char = ShimaneChar.new(char)
  		shimane_char.x = Window.width/@string.length - BASE_X + index * BASE_X * 2
	  	shimane_char.y = Window.height - BASE_Y * 2
	  	font_size = 32
	    font = Font.new(font_size)
	    shimane_char.image.draw_font(
		    (shimane_char.image.width / 2) - (font_size / 4),
		    (shimane_char.image.height / 2) - (font_size / 2),
		    char.to_s,
		    font,
		    Util::Blue
	    )
	    @shimane_chars << shimane_char
  	}
  end

  def generate_dummy array_size
    # あ~んを利用する文字として用意
  	available_chars = ("\x82\xA0".."\x82\xF1").to_a.shuffle
    # 答えと、ぁ、ぃ、ぅ、ぇ、ぉを除外
  	available_chars.delete_if{|c| c===@answer || c==="\x82\xA1" || c==="\x82\xA3" || c==="\x82\xA5" || c==="\x82\xA7"}
  	dummies = []
  	array_size.times{dummies << available_chars.shift}
  	dummies
  end

  def draw
  	@shimane_chars.each{|shimane_char|
  		shimane_char.draw
  	}
  end
end