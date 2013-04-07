require 'csv'
require 'rubygems'
require 'wordnet'
#Handline bug in wordnet
WordNet::SynsetType = {"n" => "noun", "v" => "verb", "a" => "adj", "r" => "adv"}

#To-do, find an ideal way to 
module Vocab
  class UploadWordJob
  	def perform
      #later on i can use find_or_initialize_by_name
      #but for now, i'll clear all vocab words befor every job
      VocabWord.delete_all
      csv_text = File.read(Rails.root.join('lib', 'vocab_words.txt'))
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
          #words.each { |w| puts word.gloss }
          puts "#{word.name}: #{words.uniq{|w| w.ss_type}.count}" if words.uniq{|w| w.ss_type}.count > 1
          count = count + 1 if words.uniq{|w| w.ss_type}.count > 1
        else
          puts "#{word.name}: not found"
        end
      end
      puts "COUNT : #{count}"
    end
  end
end
