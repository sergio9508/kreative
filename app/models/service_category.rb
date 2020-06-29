class ServiceCategory < ApplicationRecord
  validates :name, presence: true

  translates :name, :description, :slug

  include FriendlyIdable

  def slug_column
    :name
  end

  include MainImageable

  include Metataggable

  def self.acts_as_description
    :description
  end

  include ImageGallery

  include OrderQuery

  belongs_to :service
  # Don't forget this method, Latte uses it for many things
  def self.acts_as_label
    :name
  end

  scope :enabled, -> { where(enabled: true) }

  scope :created, -> { where('created_at < ?', Time.zone.now) }

  order_query :order_service, %i[created_at desc]
  # def next
  #   self.class.where("id > ?", id).first
  # end

  # def previous
  #   self.class.where("id < ?", id).last
  # end

  ##
  # Improve searches with ransack
  ransacker :name, type: :string do
    Arel.sql("UNACCENT(\"#{table_name}\".\"name\")")
  end
end
