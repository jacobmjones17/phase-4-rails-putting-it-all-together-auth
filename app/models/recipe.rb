class Recipe < ApplicationRecord
    belongs_to :user
    validates(:instructions, { :length => { :minimum => 50 } })
    validates :title, presence: true
end
