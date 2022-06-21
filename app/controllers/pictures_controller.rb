class PicturesController < ApplicationController
  before_action :set_picture, only: %i[ show edit update destroy ]

  def index
    @pictures = Picture.all.where.not(content: nil,image: nil)
  end

  def show
    @favorite = current_user.favorites.find_by(picture_id: @picture.id)
  end

  def new
    if params[:back]
      @picture = Picture.new(picture_params)
    else
      @picture = Picture.new
    end
  end

  def confirm
    @picture = Picture.new(picture_params)
    @picture.user_id = current_user.id 
    render :new if @picture.invalid?
  end

  def edit
    unless @picture.user_id == current_user.id
      redirect_to new_session_path
    end
  end

  def create
    @picture = Picture.new(picture_params)
    @picture.user_id = current_user.id

    respond_to do |format|
      if params[:back]
        render :new
      else
        if @picture.save
          format.html { redirect_to picture_url(@picture), notice: "写真が投稿されました" }
          format.json { render :show, status: :created, location: @picture }
          NoticeMailer.notice_mail(@picture).deliver
        else
          render :new
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @picture.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @picture.update(picture_params)
        format.html { redirect_to picture_url(@picture), notice: "Picture was successfully updated." }
        format.json { render :show, status: :ok, location: @picture }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @picture.user_id == current_user.id
      @picture.destroy
      respond_to do |format|
      format.html { redirect_to pictures_url, notice: "写真を削除しました" }
      format.json { head :no_content }
    end
    
    else
      redirect_to new_session_path notice: "ログインを行なってください"
    end
  
  end

    private

    def set_picture
      @picture = Picture.find(params[:id])
    end

    def picture_params
      params.require(:picture).permit(:content, :image, :image_cache, :user_id)
    end
end
