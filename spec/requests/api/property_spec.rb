require 'swagger_helper'

describe 'Properties API' do
  path '/api/v1/properties' do
    post 'Creates a property' do
      tags 'Properties'
      consumes 'application/json', 'application/xml'
      parameter name: :property, in: :body, schema: {
        type: :object,
        properties: {
          address: { type: :string },
          property_type: { type: :string },
          bedrooms: { type: :integer },
          sitting_rooms: { type: :integer },
          kitchens: { type: :integer },
          bathrooms: { type: :integer },
          toilets: { type: :integer },
          owner: { type: :string },
          description: { type: :string },
          valid_from: { type: :string },
          valid_to: { type: :string }
        },
        required: ['address', 'property_type', 'bedrooms', 'sitting_rooms', 'kitchens', 'bathrooms', 'toilets', 'owner', 'description', 'valid_from', 'valid_to']
      }
      response '201', 'property created' do
        let(:property) { { address: 'foo', property_type: 'bar', bedrooms: 1, sitting_rooms: 1, kitchens: 1, bathrooms: 1, toilets: 1, owner: 'foo', description: 'bar', valid_from: 'foo', valid_to: 'bar' } }
        run_test!
      end
      response '422', 'invalid request' do
        let(:property) { { address: 'foo' } }
        run_test!
      end
    end
  end

  path '/api/v1/properties/{id}' do
    get 'Retrieves a property' do
      tags 'Properties'
      produces 'application/json', 'application/xml'
      parameter name: :id, in: :path, type: :string
      response '200', 'property found' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 address: { type: :string },
                 property_type: { type: :string },
                 bedrooms: { type: :integer },
                 sitting_rooms: { type: :integer },
                 kitchens: { type: :integer },
                 bathrooms: { type: :integer },
                 toilets: { type: :integer },
                 owner: { type: :string },
                 description: { type: :string },
                 valid_from: { type: :string },
                 valid_to: { type: :string }
               },
               required: ['id', 'address', 'property_type', 'bedrooms', 'sitting_rooms', 'kitchens', 'bathrooms', 'toilets', 'owner', 'description', 'valid_from', 'valid_to']
        let(:id) { Property.create(address: 'foo', property_type: 'bar', bedrooms: 1, sitting_rooms: 1, kitchens: 1, bathrooms: 1, toilets: 1, owner: 'foo', description: 'bar', valid_from: 'foo', valid_to: 'bar').id }
        run_test!
      end
      response '404', 'property not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
