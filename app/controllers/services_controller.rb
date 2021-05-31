class ServicesController < ApplicationController
    def index
        @description = params[:description]
        @category = params[:category]
        @services = []
        if @description
            @services = Service.where(region: current_user.region).where("description LIKE ?", "%#{@description}%")
            @services = "Sorry, there are no listings for #{@description} in your area." if @services.empty?
        elsif @category
            @services = Service.where(region: current_user.region, category: params[:category])
            @services = "Sorry, there are no listings for #{@category} in your area." if @services.empty?
        end

    end

    def new
        @service = Service.new
    end

    def create 
        @service = Service.new(service_params)
        @service.archived = false
        @service.user = current_user
        @service.region = current_user.region
        if @service.save!
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
        if @service.delete!
            flash[:notice] = 'Service removed.'   
            redirect_to profile_services_path
        else
            flash[:alert] = 'Service unable to be deleted. Please try again.'
            render :destroy
        end
    end

    protected
    def service_params
        params.require(:service).permit(:category, :name, :description, :price)
    end
end
