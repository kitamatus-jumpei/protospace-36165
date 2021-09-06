class PrototypesController < ApplicationController
  # before_action :set_prototype, only: [:show]
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  # ログインしていないユーザーのページ遷移を制限
  # before_action :move_to_index, except: [:edit]
  before_action :set_prototype, only: [:show, :edit, :update, :destroy]
  #下のbefore_actionで定義しているインスタンスを定義するための記述
  before_action :move_to_edit, only: [:edit]
  # 投稿者以外のユーザーが、投稿者専用のページに遷移できないように

   def index
    @prototypes = Prototype.all
   end

   def new
     @prototype = Prototype.new
   end

  

   def create
     @prototype = Prototype.create(prototype_params)
     if @prototype.save
       redirect_to root_path
     else
       render :new
     end
   end

   def show
    # @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
   end

   def edit
    # @prototype = Prototype.find(params[:id])
   end

   def update
    # @prototype = Prototype.find(params[:id])
  
    if @prototype.update(prototype_params)
      redirect_to prototype_path
    else
      render :edit
      # render partial: "form", locals: { prototype: @prototype }
    end
   end

   def destroy
    # @prototype = Prototype.find(params[:id])
    @prototype.destroy
    redirect_to root_path
   end

  private
   def prototype_params
     params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
   end

  def set_prototype
    @prototype = Prototype.find(params[:id])

  end

   def move_to_edit
    unless current_user.id == @prototype.user_id
      # unless user_signed_in? && current_user.id == @prototype.user_id←authenticate_user!があるため、user_signed_in? &&を消去
      redirect_to action: :index
    end
  end


end
