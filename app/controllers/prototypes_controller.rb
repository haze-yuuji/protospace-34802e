class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :destroy, :new]

  def index
    @prototypes = Prototype.includes(:user)
  end
#トップ、新規一覧ページ

  def new
    @prototype = Prototype.new
  end
 #新規プロトタイプページへ遷移

  def create
       @prototype = Prototype.new(prototype_params)
   if  @prototype.save
       redirect_to root_path
   else
      render :new 
   end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])
    redirect_to root_path unless @prototype.user_id == current_user.id
  
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
       redirect_to prototype_path
    else
       render :edit
    end
  end

  def destroy
    @prototype = Prototype.find(params[:id])
   if  @prototype.destroy
       redirect_to root_path
   end
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  

end
