# encoding: UTF-8

class Ending
  def initialize
    @image = Image.load("#{File.dirname(__FILE__)}/../images/ending.jpg")
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
    Window.drawFont(150, 320, "TOTAL", @font,{:color => [255,0,0]})
    Window.drawFont(150, 420, @total_score.to_s, @font,{:color => [255,0,0]})
  end
end