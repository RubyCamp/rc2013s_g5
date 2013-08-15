# ピース1体を表現するクラス
class Piece < Sprite
  BASE_X = 50    # ピース群描画位置のX座標オフセット
  BASE_Y = 50    # ピース群描画位置のY座標オフセット

  attr_accessor :number, :pos

  # 初期化処理
  def initialize(number, pos, game)
    @number = number
    @pos = pos
    @game = game
    self.image = Util.load_image("piece_bg.png")
    font_size = 32
    font = Font.new(font_size)
    self.image.draw_font((self.image.width / 2) - (font_size / 4),
                      (self.image.height / 2) - (font_size / 2),
                       @number.to_s,
                      font, Util::Blue)
  end

  # 画面上の描画座標を更新する
  def update
    self.x = BASE_X + (Util.pos_x(@pos) * self.image.width)
    self.y = BASE_Y + (Util.pos_y(@pos) * self.image.height)
  end

  # マウスポインタ（非表示）との接触時に呼び出されるメソッド
  def hit(pointer)
    @game.piece_clicked(@pos)
  end
end