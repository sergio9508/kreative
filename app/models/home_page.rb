#
class HomePage < ApplicationRecord
  include Versionable

  # # Include this concern to enable a main image field on Latte for this model
  # # Don't forget check for the main image form partial render
  # include MainImageable

  # # Include this concern to enable a cover field on Latte for this model
  # # Don't forget check for the cover form partial render
  # include Coverable

  # Validations
  validates :name, presence: true

  # Enable multiple edition on Latte, you have to write the view and controller
  # for this, take a look to the litter example for Admins
  #
  # def self.grid?
  #   true
  # end

  # Don't forget this method, Latte uses it for many things
  def self.acts_as_label
    :name
  end

  # Improve searches with ransack
  ransacker :translations_name, type: :string do
    Arel.sql("UNACCENT(\"#{translations_table_name}\".\"name\")")
  end
  def self.instance
    first || new
  end

  # rubocop:disable MethodMissing
  #
  def self.method_missing(method, *params)
    return instance.send(method, *params) if instance.methods.include?(method)
    super
  end
end
