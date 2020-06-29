class Tecnology < ApplicationRecord
  include Versionable

  include MainImageable

  validates :name, presence: :true

  def self.acts_as_label
    :name
  end

  def self.acts_as_description
    :description
  end

  ransacker :translations_name, type: :string do
    Arel.sql("UNACCENT(\"#{translations_table_name}\".\"name\")")
  end

end
