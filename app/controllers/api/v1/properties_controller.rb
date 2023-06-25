class Api::V1::PropertiesController < ApplicationController
    def create
      property = Property.new(property_params)
      if validate_address(property.address) && property.save
        property.geocode
        render json: property, status: :created
      else
        render json: { error: 'Invalid address' }, status: :unprocessable_entity
      end
    end
  
    def show
      property = Property.find(params[:id])
      render json: property
    end
  
    def index
      if params[:owner].present?
        properties = Property.where(owner: params[:owner])
      elsif params[:bedrooms].present? || params[:bathrooms].present?
        properties = Property.where(bedrooms: params[:bedrooms], bathrooms: params[:bathrooms])
      else
        properties = Property.all
      end
      render json: properties
    end
  
    def update
      property = Property.find(params[:id])
      if validate_address(property_params[:address]) && property.update(property_params)
        property.geocode
        render json: property
      else
        render json: { error: 'Invalid address' }, status: :unprocessable_entity
      end
    end
  
    def destroy
      property = Property.find(params[:id])
      property.destroy
      head :no_content
    end
  
    private
  
    def validate_address(address)
      begin
        result = Geocoder.search(address).first
        result.present? && result.address.present?
      rescue => e
        Rails.logger.error("Geocoding error: #{e.message}")
        false
      end
    end
  
    def property_params
      params.require(:property).permit(:address, :property_type, :bedrooms, :sitting_rooms, :kitchens, :bathrooms, :toilets, :owner, :description, :valid_from, :valid_to)
    end
  end
  