class Contact < ApplicationRecord
  belongs_to :country

  validates :name, presence: true
  validates :phone, presence: true
  validates :email, presence: true
  validates :country_id, presence: true
  validates :email,
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i },
            if: proc { |o| o.email.present? }

  ##
  # Don't forget this method, Latte uses it for many things
  def self.acts_as_label
    :name
  end

  ##
  # Improve searches with ransack
  ransacker :name, type: :string do
    Arel.sql("UNACCENT(\"#{table_name}\".\"name\")")
  end

  ransacker :email, type: :string do
    Arel.sql("UNACCENT(\"#{table_name}\".\"email\")")
  end

  ransacker :phone, type: :string do
    Arel.sql("UNACCENT(\"#{table_name}\".\"phone\")")
  end

  after_create :send_email

  def send_email
    LatteMailer.contact(self).deliver_now
  end
end
