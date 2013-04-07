class VocabWord < ActiveRecord::Base
  validates :name,  presence: true, length: { minimum: 3 }
  validates :definition,  presence: true, length: { minimum: 3 }
end
