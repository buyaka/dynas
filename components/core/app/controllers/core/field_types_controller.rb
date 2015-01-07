module Core
class FieldTypesController < ApplicationController
  before_action :set_field_type, only: [:show, :edit, :update, :destroy]

  # GET /field_types
  # GET /field_types.json
  def index
    @field_types = FieldType.all
  end

  # GET /field_types/1
  # GET /field_types/1.json
  def show
  end

  # GET /field_types/new
  def new
    @field_type = FieldType.new
  end

  # GET /field_types/1/edit
  def edit
  end

  # POST /field_types
  # POST /field_types.json
  def create
    @field_type = FieldType.new(field_type_params)

    respond_to do |format|
      if @field_type.save
        format.html { redirect_to @field_type, notice: 'Field type was successfully created.' }
        format.json { render :show, status: :created, location: @field_type }
      else
        format.html { render :new }
        format.json { render json: @field_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /field_types/1
  # PATCH/PUT /field_types/1.json
  def update
    respond_to do |format|
      if @field_type.update(field_type_params)
        format.html { redirect_to @field_type, notice: 'Field type was successfully updated.' }
        format.json { render :show, status: :ok, location: @field_type }
      else
        format.html { render :edit }
        format.json { render json: @field_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /field_types/1
  # DELETE /field_types/1.json
  def destroy
    @field_type.destroy
    respond_to do |format|
      format.html { redirect_to field_types_url, notice: 'Field type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_field_type
      @field_type = FieldType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def field_type_params
      params.require(:field_type).permit(:name, :value, :note)
    end
end
end
