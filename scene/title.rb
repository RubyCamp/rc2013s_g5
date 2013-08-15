# coding: UTF-8

class Title
    def initialize
        @image = Image.load("images/title.png")
    end
    def play
        if Input.keyPush?(K_SPACE)
            Director.stop_bgm
            Director.change_bgm(:bgm)
            Director.play_bgm
            Director.change_scene(:game)
        end
        if Input.keyPush?(K_1)
            Director.change_scene(:list)
        end
        Window.draw(0, 0, @image)
    end
end