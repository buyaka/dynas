module Core
  class DatasController < WithdbController
    before_filter :set_app, :set_entity
    before_action :set_object, only: [:show, :edit, :update, :destroy]

    def index
      @datas = NoBrainer.run { |r| 
        r.db(current_member.id).table(@entity.name)
      }
    end

    def show
      
    end

    def new
      @obj = Model.new_from_db(object).new(:entity_id => @entity.id)
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
      
      def set_entity
        @entity = Entity.find(params[:entity_id])
      end
      
      def set_object
        object = NoBrainer.run { |r| 
          r.db(current_member.id).table(@entity.name).get(params[:id])
        }
        @obj = Model.new_from_db(object)
        puts @obj.column_names
      end
      
  end
end