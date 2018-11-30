class Hangman
  attr_accessor :words, :hanged, :game_words, :guessed_letters
  def initialize(words = WordList.new)
    @words = words
    @hanged = 0
    @game_word = @words.get_rand
    @guessed_letters = []
    @@game = self
  end
  def new_game()
    @hanged = 0
    @game_word = @words.get_rand
    @guessed_letters = []
  end
  def self.current_game()
    @@game
  end
  def take_turn(guess_letter)
    output = ""
    if(guess_letter == "start")
      output = display_screen(false, true, 0)
    elsif !valid?(guess_letter)
      output = display_screen(true, false, 0)
    else
      check_word = create_output_word(@game_word.chars.to_a)
      if @hanged == 4
        return display_screen(false, false, -1)
      elsif !check_word.include?("_")
        return display_screen(false, false, 1)
      end
      if !@game_word.include?(guess_letter)
        @hanged += 1
      end
      @guessed_letters.push(guess_letter)
      check_word = create_output_word(@game_word.chars.to_a)
      if @hanged == 4
        output = display_screen(false, false, -1)
      elsif !check_word.include?("_")
        output += display_screen(false, false, 1)
      else
        output = display_screen(false, false, 0)
      end
    end
    output
  end
  def valid?(guess_letter)
    if guess_letter.length != 1
      return false
    elsif @guessed_letters.include?(guess_letter)
      return false
    end
    return true
  end
  def display_screen(is_error, is_start, win_loss)
    output = display_noose + "<br>" + display_word
    if is_error
      output += "<br>Your input was invalid!  Please try again!"
    end
    if is_start
      output += "<br>Welcome to hangman!  Start whenever you are ready, or reload the page for a new word!"
    end
    if win_loss == 1
      output += "<br>Congratulations!  You win!"
    elsif win_loss == -1
      output += "<br>That sucks... you lose!"
    end
    output
  end
  def display_noose()
    output = "<span class='noose'>&nbsp&nbsp&nbsp&nbsp&nbsp-----------<br>"
    if @hanged > 0
      # Head
      output += "&nbsp&nbsp&nbsp&nbsp/\\&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp|<br>&nbsp&nbsp&nbsp&nbsp\\/&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp|<br>"
    end
    if @hanged > 1
      # Arms
      output += "&nbsp&nbsp&nbsp&nbsp&nbsp|&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp|<br>&nbsp-------&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp|<br>"
    end
    if @hanged > 2
      # Body
      output += "&nbsp&nbsp&nbsp&nbsp&nbsp|&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp|<br>&nbsp&nbsp&nbsp&nbsp&nbsp|&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp|<br>"
    end
    if @hanged > 3
      # Legs
      output += "&nbsp&nbsp&nbsp&nbsp/\\&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp|<br>&nbsp&nbsp/&nbsp&nbsp&nbsp&nbsp\\&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp|<br>"
    end
    output += create_empty_lines(2*(4 - @hanged))
    output += "       ---------------</span>"
  end
  def create_empty_lines(number)
    output = ""
    index = 0
    while index < number
      output += "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp|<br>"
      index += 1
    end
    output
  end
  def display_word
    output = ""
    word = @game_word.chars.to_a
    unused_letters = []
    output_array = create_output_word(word)
    output += "<span class='noose'>" + output_array.join(" ") + "</span><br><br>"
    @guessed_letters.each do |letter|
      if !word.include?(letter)
        unused_letters.push(letter)
      end
    end
    output += "Incorrect guesses: " + unused_letters.join(" ") + "<br>"
  end
  def create_output_word(word)
    output_array = []
    word.each do |letter|
      if @guessed_letters.include?(letter)
        output_array.push(letter)
      else
        output_array.push("_")
      end
    end
    output_array
  end
end
