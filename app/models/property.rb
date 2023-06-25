class Property < ApplicationRecord
    geocoded_by :address
    after_validation :geocode, if: :address_changed?
  
    validates :address, presence: true
    validates :property_type, presence: true
    validates :bedrooms, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validates :sitting_rooms, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validates :kitchens, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validates :bathrooms, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validates :toilets, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validates :owner, presence: true
    validates :description, presence: true
    validates :valid_from, presence: true
    validates :valid_to, presence: true
  
    validate :valid_date_range
  
    def full_address
      [address, city, state, country].compact.join(', ')
    end
  
    private
  
    def valid_date_range
      return unless valid_from && valid_to
  
      if valid_from > valid_to
        errors.add(:valid_to, "must be greater than or equal to Valid From date")
      end
    end
  end
  