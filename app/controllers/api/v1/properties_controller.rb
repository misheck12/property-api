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

    def search_by_owner
      owner = params[:owner]
      properties = Property.where(owner: params[:owner])
      render json: properties
    end

    def search_by_filters
      address = params[:address]
      property_type = params[:property_type]
      bedrooms = params[:bedrooms]
      sitting_rooms = params[:sitting_rooms]
      kitchens = params[:kitchens]
      bathrooms = params[:bathrooms]
      toilets = params[:toilets]
      owner = params[:owner]
      description = params[:description]
      valid_from = params[:valid_from]
      valid_to = params[:valid_to]
    
      properties = Property.where(address: address, property_type: property_type, bedrooms: bedrooms, sitting_rooms: sitting_rooms, kitchens: kitchens, bathrooms: bathrooms, toilets: toilets, owner: owner, description: description, valid_from: valid_from, valid_to: valid_to)
    
      render json: properties, status: :ok
    end

    def search_by_address
      address = params[:address]
      properties = Property.where(address: params[:address])
      render json: properties
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

  
  