# ゲーム内の各種便利メソッドの集合
module Util
  Blue = [0, 0, 255]  # 青色

  module_function

  # 引数で指定した画像をimagesディレクトリから読み込む
  def load_image(filename)
    return Image.load(File.join(File.dirname(__FILE__), "..", "images", filename))
  end

  # 引数で指定した配列のインデックスを二次元座標系に変換
  def pos_to_coord(pos)
    return pos_x(pos), pos_y(pos)
  end
end