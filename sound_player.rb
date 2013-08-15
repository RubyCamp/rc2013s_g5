# coding: UTF-8

require 'dxruby'

class SoundPlayer
	@@sound_list = []
	@@index = 0
	def self.set_sound path
		@@sound_list << [Sound.new(path), 0]
	end
	def self.play index
		@@sound_list[index].first.play
		@@sound_list[index][1] = 1
	end
	def self.playing?
		@@sound_list.each{|sound| return true if sound.last == 1}
		return false
	end
	def self.stop index
		@@sound_list[index].first.stop
		@@sound_list[index][1] = 0
		@@index += 1
	end
	def self.get_sound_list
		@@sound_list
	end
	def self.get_index
		@@index
	end
	def self.clear
		@@index = 0
	end
end