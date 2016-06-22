class HangpersonGame
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  attr_reader :word, :guesses, :wrong_guesses

  def guess(letter)
    raise ArgumentError if letter.nil? or letter.empty? or letter !~ /[a-z]/i
    letter.downcase!
    return false if (@guesses+@wrong_guesses).include? letter
    @word.include?(letter) ? @guesses << letter : @wrong_guesses << letter
  end
 
 def word_with_guesses
	@word.chars.map{|x| @guesses.include?(x) ? x : '-' }.join
 end
 
 def check_win_or_lose
	return :win unless word_with_guesses=~/-/
	return :lose unless @wrong_guesses.length<7
	:play
 end 

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
end

