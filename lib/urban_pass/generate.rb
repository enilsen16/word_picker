require 'open-uri'
require 'nokogiri'
require 'clipboard'

module UrbanPass
  class Generate

    def generate_word
      # Generate word:
      urban = random_word

      # Remove the extra spaces
      word = remove_spaces(urban)

      # Return the length of the phrase and print out the word
      puts "Your word is: #{word}"
      puts "The word is #{phrase_length(word)} charcters long"
    end

    def generate_phrase
      arr = []
      4.times do
        word = random_word
        arr << remove_spaces(word)
      end
      pass_phrase = arr.join
      copy(pass_phrase)
      return pass_phrase
    end

    def random_word
      page = Nokogiri::HTML(open("http://urbandictionary.com/random.php"))
      page.css('a.word')[0].text
    end

    def remove_spaces(phrase)
      phrase.gsub(" ", "")
    end


    def phrase_length(phrase)
      return phrase.length
    end


    def copy(phrase)
      word = Clipboard.copy(phrase)
      if Clipboard.paste == phrase
        puts "The password was copied correctly!!"
        return word
      end
    end
  end
end
