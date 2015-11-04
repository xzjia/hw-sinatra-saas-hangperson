class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_accessor :wrong_guesses
  attr_accessor :guesses
  attr_accessor :word
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess letter
    raise ArgumentError if letter == nil or letter == '' or letter =~ /[^\w]/
    letter.downcase!
    if @word.include? letter
      unless @guesses.include? letter
        @guesses << letter
        return true
      end
      return false
    else
      unless @wrong_guesses.include? letter
        @wrong_guesses << letter
        return true
      end
      return false
    end
  end
  
  def word_with_guesses
    current_status = @word.dup
    @word.each_char do |letter|
      current_status.gsub!(letter, '-') if !@guesses.include?(letter)
    end
    return current_status
  end

  def check_win_or_lose
    if @wrong_guesses.length >= 7
      return :lose
    elsif self.word_with_guesses == @word
      return :win
    else
      return :play
    end
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
