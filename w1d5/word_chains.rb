require 'set'
file = File.open("./dictionary.txt")


class WordChainer

    def initialize(file)
        word_set = Set.new(file.read.split)
        @dictionary = word_set
    end


    def adjacent_words(word_input)
        adj_words = []
        same_length_words = @dictionary.select { |el| el.length == word_input.length}
        
        same_length_words.each do |word|
            mismatch = 0
            (0...word.length).each do |idx|
                mismatch += 1 if word[idx] != word_input[idx]
            end
            adj_words << word if mismatch == 1
        end
        adj_words
    end

    def run(source, target = nil)
        @current_words = [source]
        @all_seen_words = {}
        @all_seen_words[source] = nil

        # while !@current_words.empty?
        while !@all_seen_words.include?(target)
            self.explore_current_words        
        end
    
        build_path(target)
    end

    def explore_current_words
        new_current_words = []

        @current_words.each do |current_word|
            adjacent_words(current_word).each do |word|
                next if @all_seen_words.include?(word)
                new_current_words << word
                @all_seen_words[word] = current_word
            end
        end

        @current_words = new_current_words
    end

    def build_path(target)
        # return if target[0] == nil
        # path = [target]

        # @all_seen_words.each_key do |key|
        #     if @all_seen_words[key] == target[0]
        #         path.unshift(key)
        #         build_path(path)
        #     end
        # end
        # path

        path = []
        current_word = target
        
        until current_word.nil?
          path << current_word
          current_word = @all_seen_words[current_word]
        end

        path.reverse
    end

end

try = WordChainer.new(file)
p try.run("market", "legion")
