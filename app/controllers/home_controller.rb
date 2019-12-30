class HomeController < ApplicationController
  
  def index
  end
  
  #完成品一覧
  def paint_list
    @pictures = Paint.all.page(params[:page]).per(5)

    render template: 'common/list'
  end
  
  #線画一覧
  def senga_list
    
    #自分の投稿リスト
    if params[:user_id]
      @pictures = Senga.where(:user_id => params[:user_id]).page(params[:page]).per(5)
    
    #申請リスト
    elsif params[:type] && params[:type] == 'requests'
      @pictures = Senga.joins(:senga_requests).where(senga_requests:{user_id: current_user.id}).where.not(senga_requests:{permission: false}).page(params[:page]).per(5)
    
    #線画のお気に入りリスト
    elsif params[:type] && params[:type] == 'like'
      @pictures = Senga.joins(:senga_likes).where(senga_likes:{user_id: current_user.id}).page(params[:page]).per(5)
      
    #完成品お気に入りリスト
    elsif params[:type] && params[:type] == 'like'
      @pictures = Senga.joins(:senga_likes).where(senga_likes:{user_id: current_user.id}).page(params[:page]).per(5)
    
    #許可済み知スト
    elsif params[:type] && params[:type] == 'permitted'
      @pictures = Senga.joins(:senga_requests).where(senga_requests:{user_id: current_user.id,permission: true}).page(params[:page]).per(5)
    
    #カテゴリー検索リスト
    elsif params[:type] && params[:type] == 'category'
      @pictures = Senga.joins(:senga_categories).where(senga_categories:{category_id: params[:category]}).page(params[:page]).per(5)
    
    else
      #線画リスト
      @pictures = Senga.all.page(params[:page]).per(5)

    end
    
    if params[:word].present?
     @pictures = Senga.where("caption like ?", "%#{params[:word]}%").order("id desc")
     render template: 'common/list'
    else
      render template: 'common/list'
    end
    
  end
  
  def create_png
    senga = Senga.find(params[:id])
    require 'psd'
    @psd = PSD.new('/home/ec2-user/environment/paintline/public' + senga.image.url)
    @psd.parse!
    @psd.image.save_as_png '/home/ec2-user/environment/paintline/public' + senga.image.url + '.png'
  end
  
  
  def new
    render template: 'common/new'
  end
  
end
