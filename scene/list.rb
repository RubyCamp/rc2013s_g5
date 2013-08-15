# coding: UTF-8

class List
    def initialize
        @image = Image.load("#{File.dirname(__FILE__)}/../images/mondai.jpg")
    end
    def play
        if Input.keyPush?(K_SPACE)
            Director.change_scene(:title)
        end
        Window.draw(0, 0, @image)
    end
end