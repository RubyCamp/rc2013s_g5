# coding: UTF-8

require 'dxruby'

require_relative 'director'

Window.width  = 800  # ゲームウィンドウ横幅
Window.height = 600  # ゲームウィンドウ縦幅

director = Director.new

# メインループ開始
Window.loop do
	break if Input.keyPush?(K_ESCAPE) # ESC押下で強制終了
	director.play
end
