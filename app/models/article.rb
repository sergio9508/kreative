class Article < ApplicationRecord
  belongs_to :authors

  translates :name, :category, :content, :slug, :summary

  include FriendlyIdable

  include Versionable

  include ImageGallery

  include MainImageable

  include Metataggable

  def slug_column
    :name
  end

  validates :name, presence: true

  def self.acts_as_label
    :name
  end

  def self.acts_as_description
    :content
  end

  def self.search
    paginate(page: page, per_page: 5)
  end

  def dateshort
    I18n.l published_at, format: :long
  end

  scope :in_home, -> { where(in_home: true) }
  scope :priority, -> { where(priority: true) }
  scope :enabled, -> { where(enabled: true) }
  
  ransacker :translations_name, type: :string do
    Arel.sql("UNACCENT(\"#{translations_table_name}\".\"name\")")
  end
end
