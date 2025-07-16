# frozen_string_literal: true

require 'spec_helper'

describe ToAvataxHash do
  subject { address.to_avatax_hash }

  context "with Spree::Address" do
    let(:address) { build(:address) }

    it { is_expected.to be_kind_of(Hash) }

    context "with no address2" do
      before { address.address2 = nil }

      it { expect(subject[:line2]).to be_nil }
    end

    context "with empty address2" do
      before { address.address2 = "" }

      it { expect(subject[:line2]).to be_nil }
    end
  end

  context "with Spree::StockLocation" do
    let(:address) { build(:stock_location) }

    it { is_expected.to be_kind_of(Hash) }
  end
end
