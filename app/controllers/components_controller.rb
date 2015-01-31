class ComponentsController < ApplicationController
  def index
    @components = Component.all
  end
  
  def show
    @component = Component.find(params[:id])
  end

  def new
    @component = Component.new
  end
  
  def create
    @component = Component.new(component_params)
    if @component.save
      flash[:success] = @component.component_name + " created."
      redirect_to @component
    else
      render 'new'
    end
  end

  def edit
    @component = Component.find(params[:id])
  end
  
  def update
    @component = Component.find(params[:id])
    
    if @component.update(component_params)
      flash[:success] = @component.component_name + " updated."
      redirect_to @component
    else
      render 'edit'
    end
  end
  
  def destroy
     @component = Component.find(params[:id])
     @component.destroy
     flash[:success] = @component.component_name + " removed."
     
     redirect_to components_path
  end

  private
    def component_params
      params.require(:component).permit(:component_name, :asset_type_code, :component_desc, :default_requirement)
    end
end
