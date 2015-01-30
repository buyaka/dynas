module Core
  class EntitiesController < WithdbController
    before_filter :set_app
    before_action :set_object, only: [:show, :edit, :update, :destroy]

    def index
      @entities = Entity.where(:app_id => @app.id)
    end

    def show
      @fields = Field.where(:entity_id => @entity.id)
    end
    
    def document
    end

    def new
      @entity = Entity.new(:app_id => @app.id)
    end

    def edit
    end

    def create
      @entity = Entity.new(entity_params)
      @entity.app_id = @app.id
      @entity.name = @entity.name.downcase

      respond_to do |format|
        if @entity.save
          format.html { redirect_to @entity, notice: 'Entity was successfully created.' }
          format.json { render :show, status: :created, location: @entity }
        else
          format.html { render :new }
          format.json { render json: @entity.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @entity.update(entity_params)
          format.html { redirect_to @entity, notice: 'Entity was successfully updated.' }
          format.json { render :show, status: :ok, location: @entity }
        else
          format.html { render :edit }
          format.json { render json: @entity.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @entity.destroy
      respond_to do |format|
        format.html { redirect_to entities_url, notice: 'Entity was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
      def set_app
        @app = App.find(params[:app_id])
      end

      def set_object
        @entity = Entity.find(params[:id])
      end
      
      def entity_params
        params.require(:entity).permit(:name, :app_id, :note)
      end
  end
end