class VocabWord < ActiveRecord::Base
  validates :name,  presence: true, length: { minimum: 3 }
  validates :definition,  presence: true, length: { minimum: 3 }

  scope :except, ->(word) { where('id != ?', word.id) }
  scope :with_same_type_as, ->(word) { where(word_type: word.word_type) }
end
