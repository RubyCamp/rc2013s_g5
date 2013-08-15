# coding: UTF-8

# ゲーム本体シーンの管理用クラス
class Gameover
    def initialize
        @image = Image.load("images/gameover.jpg")
        @font=Font.new(78)
    end
    def clear
        @score = 0
        @total_score = 0
    end
    def play
    	if @score.nil? 
           @score = Director.get_score
        end 
        if @total_score.nil? 
           @total_score = Director.get_total_score
        end
        if Input.keyPush?(K_SPACE)
            Director.init_score
            clear
            Director.change_bgm(:op)
            Director.play_bgm
            Director.change_scene(:title)
        end
        Window.draw(0, 0, @image)
        Window.drawFont(110, 280, "TOTAL", @font,{:color => [0,0,0]})
        Window.drawFont(110, 380, @total_score.to_s, @font,{:color => [0,0,0]})
    end
end