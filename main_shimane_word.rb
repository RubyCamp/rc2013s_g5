# coding: UTF-8

require 'dxruby'
require_relative 'shimane_word_manager'

Window.width  = 800  # ゲームウィンドウ横幅
Window.height = 600  # ゲームウィンドウ縦幅

path = "#{File.dirname(__FILE__)}/shimane_words.json"
shimane_word_manager = ShimaneWordManager.new path

# メインループ開始
Window.loop do
  break if Input.keyPush?(K_ESCAPE) # ESC押下で強制終了
  shimane_word_manager.switch if Input.keyPush?(K_1)


  Sprite.update(shimane_word_manager.targets)

  Sprite.draw(shimane_word_manager.targets)
  Sprite.draw(shimane_word_manager.current_word)
end
