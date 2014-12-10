class WordChainer
  attr_reader :dictionary
  
  def initialize(dictionary_file_name)
    @dictionary = File.readlines(dictionary_file_name).map(&:chomp)
    @current_words = []
    @all_seen_words = []
  end
  
  
  def adjacent_words(word)
    correct_length_words = correct_length(word)
    correct_length_words.select { |adj_word| !more_than_one_difference?(adj_word,word) }
  end
  
  def correct_length(word)
    @dictionary.select { |dict_word| dict_word.length == word.length }
  end
  
  def more_than_one_difference?(word1,word2)
    differences = 0
    word1.split("").each_index do |idx|
      differences += 1 if word1[idx] != word2[idx]
    end
    return true if differences > 1
    return false
  end
  
  def run(source,target)
    @current_words << source
    @all_seen_words << source
    
    until @current_words.empty?
      new_current_words = []
      @current_words.each do |word|
        adjacent_list = adjacent_words(word)
        adjacent_list.each do |adjacent_word|
          if !@all_seen_words.include?(adjacent_word)
            new_current_words << adjacent_word
            @all_seen_words << adjacent_word
          end
        end
      end
      p new_current_words
      @current_words = new_current_words.dup
    end
  end
  
end


test = WordChainer.new("dictionary.txt")
p test.run("duck","ruby")

#create array
#word_array. each index |i|, 
#create rejex
#correct_words << match words in dictionary with regex