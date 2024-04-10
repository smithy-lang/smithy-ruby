class HighScore < ApplicationRecord
  validates :game, length: { minimum: 2 }
end
