# frozen_string_literal: true

module ToAvataxHash
  def to_avatax_hash
    {
      line1: address1,
      line2: address2.presence,
      city: city,
      region: state.try(:abbr),
      country: country.try(:iso),
      postalCode: zipcode
    }
  end
end
