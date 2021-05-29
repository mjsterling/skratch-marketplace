class ServicesController < ApplicationController
    attr_accessor :services, :description, :category

    def index
        unless profile_complete?
            flash[:alert] = 'Please complete your profile to use Skratch.'
            redirect_to edit_user_registration_path and return
        end

        @description = params[:description]
        @category = params[:category]
        @services = nil
        if @description
            @services = Service.where(region: current_user.region).where("description LIKE ?", "%#{@description}%")
        elsif @category
            @services = Service.where(region: current_user.region, category: params[:category])
        end
    end

    def new
        @service = Service.new
    end

    def create 
        params[:service][:region] = current_user.region
        @service = Service.new(service_params)
        @service.user = current_user
        if @service.save
          flash[:notice] = 'Service added successfully.'   
          redirect_to profile_services_path
        else
          @service.errors.messages
          flash[:alert] = 'Failed to add service.'   
          render :new       
        end    
    end

    def edit
        @service = Service.find(params[:id])
        authorize_user!(@service)
    end

    def update
        @service = Service.find(params[:id])
        authorize_user!(@service)
        if @service.update(service_params)
          flash[:notice] = 'Service updated successfully.'   
          redirect_to profile_services_path
        else
          flash[:alert] = 'Failed to update service.'
          render :edit
        end
    end

    def destroy
        @service = Service.find(params[:id])
        authorize_user!(@service)
        if @service.delete
            flash[:notice] = 'Service removed.'   
            redirect_to profile_services_path
        else
            flash[:alert] = 'Service unable to be deleted. Please try again.'
            render :destroy
        end
    end

    protected
    def service_params
        params.require(:service).permit(:region, :category, :name, :description, :price)
    end
end
