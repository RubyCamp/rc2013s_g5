# coding: UTF-8

require "dxruby"
require_relative 'ima'
require_relative 'teki'
Window.width = 800
Window.height = 600

#class Tama
a = 0
b = 0
diff_x = 0
diff_y = 0

#かめ画像読み込み
tamaa = Image.load("./images/kame.png")
tama = Sprite.new(400,450,tamaa)
#弾画像読み込み
imaa= Image.load("./images/kame.png")
ima = Ima.new(-60,-60,imaa)
#敵画像読み込み
tekii = Image.load("./images/tekikame.png")
teki = Teki.new(400,300,tekii)

Window.loop do
  break if Input.keyPush?(K_ESCAPE)  #Esc終了

  tama.x = tama.x + Input.x * 2  #かめ横移動

  #左クリックで弾発射
  if Input.mousePush?(M_LBUTTON) == true and
      (ima.y <= -50 or ima.x <= -imaa.width or 800+imaa.width < ima.x) and
      Input.mousePosY < tama.y then
    ima.x = tama.x
    ima.y = tama.y
    a = Input.mousePosX  #クリックした場所のx座標
    b = Input.mousePosY  #クリックした場所のy座標
    diff_x = (tama.x-a)/60.0
    diff_y = (tama.y-b)/60.0
  end

  unless ima.y <= -50 or ima.x <= -imaa.width or 800+imaa.width < ima.x
    ima.x -= diff_x
    ima.y -= diff_y
  end

  Window.draw(tama.x, tama.y, tamaa)  #かめの出力
  if -50 < ima.y
    ima.draw #弾の出力
  end
  Window.draw(teki.x, teki.y, tekii) if teki.y > 0  #敵の出力

  Sprite.check(ima,teki)
end
