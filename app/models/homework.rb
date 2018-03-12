class Homework < ApplicationRecord
    has_many :submissions, dependent: :destroy
end
