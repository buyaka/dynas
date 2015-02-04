module Core
  class DatasController < WithdbController
    before_filter :set_app, :set_entity, :get_attributes
    before_action :set_object, only: [:show, :edit, :update, :destroy]

    def index
      @datas = NoBrainer.run { |r| 
        r.db(current_member.id).table(@entity.name)
      }
    end

    def show

    end

    def new
      #str_class_name = @entity.name.slice(0,1).capitalize + @entity.name.slice(1..-1)
      #@data = Object.const_set(str_class_name,Class.new)
      # str_fields = ""
      # @attrs.each  do |a|
      #   str_fields += "field :#{a.name}, :type => #{a.field_type}\n"
      # end
      # str_class = "class "+str_class_name+" 
      # include NoBrainer::Document 
      # NoBrainer::Document::DynamicAttributes
      # #{str_fields}
      # end "
    end

    def edit
    end

    def create
      prms  = params[:data]
      jsonData = JSON.parse(prms.to_json)
      @result = NoBrainer.run { |r| 
        r.db(current_member.id).table(@entity.name).insert(jsonData)
      }
      respond_to do |format|
        if (@result["errors"] == 0) 
          format.html { redirect_to app_entity_datas_url(@app, @entity), notice: 'Data was successfully added.' }
        else
          format.html { render :new }
        end
      end
    end

    def update
      prms  = params[:data]
      jsonData = JSON.parse(prms.to_json)
      @result = NoBrainer.run { |r| 
        r.db(current_member.id).table(@entity.name).get(@object['id']).update(jsonData)
      }
      respond_to do |format|
        if (@result["errors"] == 0) 
          format.html { redirect_to app_entity_datas_url(@app.id, @entity.id), notice: 'Data was successfully updated.' }
        else
          format.html { render :edit }
        end
      end
    end

    def destroy
      @result = NoBrainer.run { |r| 
        r.db(current_member.id).table(@entity.name).get(@object['id']).delete()
      }
      if (@result["errors"] == 0) 
        nt = 'Data was successfully destroyed.' 
      else
       nt =  'Data was not destroyed.' 
     end

     respond_to do |format|
      format.html { redirect_to app_entity_datas_url(@app.id, @entity.id), notice: nt }
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
    @object = NoBrainer.run { |r| 
      r.db(current_member.id).table(@entity.name).get(params[:id])
    }
  end

  def get_attributes
    @attrs = Field.where(:entity_id => @entity.id)
  end

end
end