# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VenueCreator, type: :service do
  describe 'creates venue with seats' do
    context 'creates venue successfully' do
      let(:valid_venue) do
        FactoryBot.attributes_for(:venue)
      end

      it '.perform' do
        expect(described_class.new(params: valid_venue).perform).to eq(1)
      end
    end

    context 'do not create venue' do
      let(:invalid_venue) do
        { rows: 1, columns: 1 }
      end

      it '.perform' do
        expect(described_class.new(params: invalid_venue).perform).to eq(false)
      end
    end
  end
end

