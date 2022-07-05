require "set"
require 'byebug'

class Wordchainer
    attr_reader :dictionary

    def initialize(dictionary_file_name)
        @dictionary = File.readlines(dictionary_file_name).map(&:chomp)
        @dictionary = Set.new(@dictionary)
        
    end

    def run(source, target)
        @current_words, @all_seen_words = [source] , {source => nil}

        until @current_words.empty?

            explore_current_words

        end
        build_path(target)
    end

    def explore_current_words
        new_current_words = []
    
        @current_words.each do |current_word|
    
            adjacent_words(current_word).each do |adjacent_word|                  
            next if @all_seen_words.key?(adjacent_word)

            new_current_words << adjacent_word                     
            @all_seen_words[adjacent_word] = current_word                        

            end
        end
        @current_words = new_current_words

    end

    def build_path(target)
        #recursively 
        if @all_seen_words[target] == nil
            return [target]
        end
        path = [target]
        target = @all_seen_words[target]
        path = build_path(target) + path

        #traversing hash
        # path = []
        # until target.nil?
        #     path << target
        #     target = @all_seen_words[target]
        # end
        # path.reverse
    end

    def adjacent_words(word)
        adjacent_words = []

        word.each_char.with_index do |old_char, i|
            ('a'..'z').each do |new_char|

                next if old_char == new_char

                new_word = word.dup
                new_word[i] = new_char

                adjacent_words << new_word if dictionary.include?(new_word)
            end
        end

        adjacent_words

    end

end


x = Wordchainer.new("dictionary.txt")
p x.run("market", "battle")
