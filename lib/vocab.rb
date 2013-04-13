require 'csv'
require 'rubygems'
require 'wordnet'
#Handline bug in wordnet
WordNet::SynsetType = {"n" => "noun", "v" => "verb", "a" => "adj", "r" => "adv"}

#1 ran UploadWordJob with vocab_words
#2 ran UpdateDefTypeJob
#3 exported csv as vocab_words_w_type
#4 update missing/ambigous word_types manually
#5 UploadWordJob with vocab_words_w_type

#To-do, find an ideal way to 
module Vocab
  class UploadWordJob
  	def perform
      #later on i can use find_or_initialize_by_name
      #but for now, i'll clear all vocab words befor every job
      VocabWord.delete_all
      csv_text = File.read(Rails.root.join('lib', 'vocab_words_w_type.csv'))
      csv = CSV.parse(csv_text, :headers => true)
      csv.each do |row|
        row = row.to_hash.with_indifferent_access
        VocabWord.create!(row.symbolize_keys)
      end
    end
  end

  class UpdateDefTypeJob
    def perform
      count = 0 #ambigous word type
      VocabWord.all.each do |word|
        lemmas = WordNet::WordNetDB.find(word.name)
        if lemmas.count > 0
          synsets = lemmas.map { |lemma| lemma.synsets }
          words = synsets.flatten
          word_types = words.uniq{|w| w.ss_type}
          count = count + 1 if word_types.count > 1
          word.word_type = word_types.first.ss_type if word_types.count == 1
          word.save!
        else
          puts "#{word.name}: not found"
        end
      end
      puts "Words with multiple types : #{count}"
    end
  end
end
