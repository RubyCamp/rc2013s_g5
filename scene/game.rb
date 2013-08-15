# coding: UTF-8

# ゲーム本体シーンの管理用クラス
require_relative '../shimane_word_manager'
require_relative '../tama'
require_relative '../timer'
require_relative '../ima'
class Game

  # ゲームシーンの初期化
  def initialize
    @image = Util.load_image("bg1.jpg")
    path = "#{File.dirname(__FILE__)}/../shimane_words.json"
    @shimane_word_manager = ShimaneWordManager.new path, 2, 1
    @tama = Tama.new(Window.width/2,Window.height - 150,Image.load("#{File.dirname(__FILE__)}/../images/player_shimanekko.png"))
    @ima = Ima.new(-5000,-5000,Image.load("#{File.dirname(__FILE__)}/../images/aji.png"))
    @hassya = Sound.new("./music/kouka/tama1.wav")  #発射音
    @score = 0
    @font=Font.new(40, "Mv Boli")
    @timer = Timer.new 30
    @shot_x = 0
    @shot_y = 0
    @diff_x = 0
    @diff_y = 0
    @ima_angle = 0
  end

  def clear
        @image = Util.load_image("bg.jpg")
        path = "#{File.dirname(__FILE__)}/../shimane_words.json"
        @shimane_word_manager = ShimaneWordManager.new path, 2
        @tama = Tama.new(Window.width/2,Window.height - 150,Image.load("#{File.dirname(__FILE__)}/../images/player_shimanekko.png"))
        @ima = Ima.new(-50,-50,Image.load("#{File.dirname(__FILE__)}/../images/aji.png"))
      	@score = 0
      	@timer = Timer.new 30
      	@shot_x = 0
        @shot_y = 0
        @diff_x = 0
        @diff_y = 0
        @ima_angle = 0
  end

  # シーンの進行（1フレーム分）
  def play
    # シーン背景の描画
    Window.draw(0, 0, @image)
    #左クリックで弾発射
    if Input.mousePush?(M_LBUTTON) == true and
      (@ima.y <= -50 or @ima.x <= -@ima.image.width or 800+@ima.image.width < @ima.x) and
      Input.mousePosY < @tama.y then
      #0 <= @ima.x  or 800 < @ima.x
      @ima.x = @tama.x
      @ima.y = @tama.y
      @shot_x = Input.mousePosX  #クリックした場所のx座標
      @shot_y = Input.mousePosY  #クリックした場所のy座標
      @diff_x = (@tama.x-@shot_x)/60.0
      @diff_y = (@tama.y-@shot_y)/60.0
      @hassya.play
      @ima_angle = Math.atan2(@tama.y-@shot_y, @tama.x-@shot_x)*180/(Math::PI)
    end

      @diff_x *= -1 if @ima.x <= 0 or 800 < @ima.x+@ima.image.width
      @ima_angle = 180 - @ima_angle * 2 if @ima.x <= 0 
      @ima_angle = 360 - @ima_angle * 2 if 800 < @ima.x+@ima.image.width

    unless @ima.y <= -50 or @ima.x <= -@ima.image.width or 800+@ima.image.width < @ima.x
      @ima.x -= @diff_x
      @ima.y -= @diff_y
    end

    @tama.draw  #かめの出力
    if -50 < @ima.y
      Window.drawRot(@ima.x, @ima.y, @ima.image, @ima_angle)
    end

    @shimane_word_manager.switch if Input.keyPush?(K_1)
    if Input.keyPush?(K_2)
      clear
      Director.change_scene(:title)
    end

    # 更新
    @tama.update
    Sprite.update(@shimane_word_manager.targets)

    # timer関連
    if @timer.stop? 
      # スコアの判定
      score_judge
    else 
      @timer.update
      @timer.draw
    end

    # 画面外に的が出たのかを判定
    @shimane_word_manager.targets.each{|target| 
      @shimane_word_manager.switch if target.out_screen?
      hit_target = @ima.check(target).first 
      unless hit_target.nil?         
        if hit_target.is_answer
          @score += 1000
          @shimane_word_manager.switch   
        else
          @score -= 500
        end
        @ima.shot(target)
        target.hit(@ima)
      end
    }

    # 描画
    Window.drawFont(Window.width - 140,Window.height - 100,"score",@font, {:color => [0,0,0]})
    Window.drawFont(Window.width - 140,Window.height - 60,@score.to_s,@font, {:color => [0,0,0]})
    Sprite.draw(@shimane_word_manager.targets)
    Sprite.draw(@shimane_word_manager.current_word)

    # cleaning
    Sprite.clean(@shimane_word_manager.targets)
    @tama.draw
  end

  # スコアを見てクリアか否か判定
  def score_judge
    # ゲームクリア条件の判定を行い、クリアしていればエンディングシーンへ遷移
      Director.set_score(@score)
      Director.stop_bgm
    if cleared?
    	clear
      Director.change_scene(:stage1to2)
    elsif missed?
    	clear
      Director.change_scene(:gameover)
    end
  end

  # クリア判定
  def cleared?
    @score >= 2500
  end
  def missed?
    @score < 2500
  end
end