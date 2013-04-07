require 'csv' 

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
end
