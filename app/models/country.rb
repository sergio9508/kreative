class Country < ApplicationRecord
    has_many :contacts
    ##
    # Don't forget this method, Latte uses it for many things
    def self.acts_as_label
        :name
    end

    scope :priority,  -> { order(priority: :desc) }
end
