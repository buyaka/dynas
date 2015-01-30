module Core
  class FieldsController < WithdbController
    before_filter :set_app, :set_entity
    before_action :set_object, only: [:show, :edit, :update, :destroy]

    def index
      @fields = Field.where(:app_id => @app.id, :entity_id => @entity.id)
    end

    def show
    end
    
    def document
    end

    def new
      @field = Field.new(:app_id => @app.id, :entity_id => @entity.id)
    end

    def edit
    end

    def create
      @field = Field.new(field_params)
      @field.app_id = @app.id
      @field.entity_id = @entity.id
      @field.name = @field.name.downcase

      respond_to do |format|
        if @field.save
          format.html { redirect_to @field, notice: 'Field was successfully created.' }
          format.json { render :show, status: :created, location: @field }
        else
          format.html { render :new }
          format.json { render json: @field.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @field.update(field_params)
          format.html { redirect_to @field, notice: 'Field was successfully updated.' }
          format.json { render :show, status: :ok, location: @field }
        else
          format.html { render :edit }
          format.json { render json: @field.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @field.destroy
      respond_to do |format|
        format.html { redirect_to app_entity_fields_url, notice: 'Field was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
      def set_app
        @app = App.find(params[:app_id])
      end

      def set_entity
        @entity = Entity.find(params[:entity_id])
      end
      

      def set_object
        @field = Field.find(params[:id])
      end
      
      def field_params
        params.require(:field).permit(:name, :app_id, :entity_id, :field_type, :note)
      end
  end
end