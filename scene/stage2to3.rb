# coding: UTF-8

class Stage2to3
    def initialize
        @image = Image.load("#{File.dirname(__FILE__)}/../images/stageclear.jpg")
        @font=Font.new(78)
    end
    def play
    	if @score.nil? 
           @score = Director.get_score
        end 
        if Input.keyPush?(K_SPACE)	
            Director.play_bgm
            Director.change_scene(:game3)
        end
        Window.draw(0, 0, @image)
        Window.drawFont(110, 280, "TOTAL", @font,{:color => [255,0,0]})
        Window.drawFont(110, 380, @score.to_s, @font,{:color => [255,0,0]})
    end
end