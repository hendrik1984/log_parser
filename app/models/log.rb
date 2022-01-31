class Log < ApplicationRecord
    has_one_attached :file
    validates :name, presence: true
end
