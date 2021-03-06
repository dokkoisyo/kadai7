class PicturesController < ApplicationController
  before_action :authenticate_user
  def authenticate_user
    unless logged_in?
      redirect_to new_session_path
    end
  end
  before_action :set_picture, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}
  def index
    @pictures = Picture.all
  end
  def show
  end
  def new
    if params[:back]
      @picture = Picture.new(picture_params)
    else
      @picture = Picture.new
    end
  end
  def confirm
    @picture = current_user.pictures.build(picture_params)
    render :new if @picture.invalid?
  end
  def edit
  end
  def create
    @picture = current_user.pictures.build(picture_params)
    if @picture.save
      redirect_to pictures_path
    else
      render :new
    end
  end
  def update
    respond_to do |format|
      if @picture.update(picture_params)
        format.html { redirect_to @picture, notice: 'Picture was successfully updated.' }
        format.json { render :show, status: :ok, location: @picture }
      else
        format.html { render :edit }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end
  def destroy
    @picture.destroy
    respond_to do |format|
      format.html { redirect_to pictures_url, notice: 'Picture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
    private
    def set_picture
      @picture = Picture.find(params[:id])
    end
    def picture_params
      params.require(:picture).permit(:image, :image_cache, :content)
    end
end
