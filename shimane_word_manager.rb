# coding: UTF-8

# Ruby合宿2013夏
require 'json'
require_relative 'shimane_word'
require_relative 'target'

class ShimaneWordManager
	attr_accessor :targets, :shimane_words, :current_word

	def initialize file_path, dummy_size=2, difficulty=1
		load file_path
		@dummy_size = dummy_size
		@difficulty = difficulty
		set
		key_change
	end

	def load file_path
		@shimane_words = []
		open(file_path) do |io|
			JSON.load(io).shuffle.each{|word| @shimane_words << ShimaneWord.new(word)}
		end
	end	

	def set
		@current_key = 0
		@current_word = @shimane_words[@current_key]
		set_targets
	end

	def set_targets
		@targets = []
		@targets << Target.new(@current_word.answer, "ball#{rand(1..4)}", true, @difficulty)
		@current_word.generate_dummy(@dummy_size).each{|char| targets << Target.new(char, "ball#{rand(1..4)}", false, @difficulty)}
		@targets.shuffle.each_with_index{|target, index| target.set_position((index+1)*110, 0)}
	end

	def key_change
		@current_key = (@current_key+1) % @shimane_words.length
	end

	def reload
		@shimane_words = @shimane_words.shuffle
		set
	end

	def switch 
		key_change
		@current_word = @shimane_words[@current_key]
		set_targets
	end

end