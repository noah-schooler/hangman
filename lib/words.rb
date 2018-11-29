class WordList
  attr_reader :words
  def initialize()
    @words = []
    @words.push("canoe")
    @words.push("book")
    @words.push("animal")
    @words.push("telephone")
    @words.push("programming")
    @words.push("computer")
    @words.push("javascript")
    @words.push("skyscraper")
    @words.push("notebook")
    @words.push("headphones")
  end
  def get_rand()
    @words[rand(@words.length)]
  end
end
