class About < ApplicationRecord
  include Versionable

  ##
  # Include this concern to enable a cover field on Latte for this model
  # Don't forget check for the cover form partial render
  translates :content, :description, :summary

  include Coverable

  include MainImageable

  def self.instance
    first || new
  end

  # rubocop:disable MethodMissing
  #
  def self.method_missing(method, *params)
    return instance.send(method, *params) if instance.methods.include?(method)
    super
  end

  def self.acts_as_label
    :name
  end

  
end
