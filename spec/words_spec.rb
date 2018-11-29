require('rspec')
require('words')

describe('WordList') do
  describe('#initialize') do
    it('will create a list of words for hangman') do
      words = WordList.new()
      expect(words.words).to(eq(["canoe", "book", "animal", "telephone", "programming", "computer", "javascript", "skyscraper", "notebook", "headphones"]))
    end
  end
end
