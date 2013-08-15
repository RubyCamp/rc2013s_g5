# coding: UTF-8

require_relative 'lib/util'

require_relative 'scene/title'
require_relative 'scene/list'
require_relative 'scene/game'
require_relative 'scene/game2'
require_relative 'scene/game3'
require_relative 'scene/ending'
require_relative 'scene/stage1to2'
require_relative 'scene/stage2to3'
require_relative 'scene/gameover'


# ゲーム進行管理用クラス
class Director
  @@score = 0
  @@total_score = 0

  # 初期化処理
  def initialize
    # ゲームを構成する各シーンの管理オブジェクトを生成
    @@scenes = {}
    @@scenes[:title]  = Title.new
    @@scenes[:list]   = List.new
    @@scenes[:game]   = Game.new
    @@scenes[:stage1to2]   = Stage1to2.new
    @@scenes[:game2]   = Game2.new
    @@scenes[:stage2to3]   = Stage2to3.new
    @@scenes[:game3]   = Game3.new
    @@scenes[:ending] = Ending.new
    @@scenes[:gameover] = Gameover.new
    @@current_scene = :title

    @@bgm = {}
    @@bgm[:op] = Sound.new("./music/start/tamji03.mid")
    @@bgm[:bgm] = Sound.new("./music/bgm/60s.mid")
    @@current_bgm = :op
    @@bgm[@@current_bgm].play
  end

  # シーン進行メソッド
  def play
    # 現在設定されているシーン管理オブジェクトのplayメソッドへ
    # 処理を委譲する
    @@scenes[@@current_scene].play
  end

  # シーン切り替え用メソッド
  # ===引数
  # scene: 切り替え先シーンの名称
  #        シンボルで指定する（例： Director.change_scene(:ending)）
  def self.change_scene(scene)
    @@current_scene = scene
  end

  def self.stop_bgm
    @@bgm[@@current_bgm].stop
  end
  def self.play_bgm
    @@bgm[@@current_bgm].play
  end
  def self.change_bgm(bgm)
    @@current_bgm = bgm 
  end
  def self.set_score(score)
    @@score = score
    @@total_score += @@score
  end

  def self.init_score
    @@score = 0
    @@total_score = 0
  end

  def self.get_score
    return @@score
  end

  def self.get_total_score
    return @@total_score
  end
end