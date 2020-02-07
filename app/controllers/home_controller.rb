class HomeController < ApplicationController
  
  def index
  end
  
  #完成品一覧
  def paint_list
    if params[:user_id]
      @pictures = Paint.where(:user_id => params[:user_id]).order(created_at: :desc).page(params[:page]).per(8)
    
    else
      @pictures = Paint.all.order(created_at: :desc).page(params[:page]).per(8)
      render template: 'common/list'
    end
    
    if params[:word].present?
     @pictures = Senga.where("caption like ?", "%#{params[:word]}%").order("id desc")
     render template: 'common/list'
    end
    
  end
  
  #一覧
  def senga_list
    
    #自分の投稿リスト
    if params[:user_id]
      @pictures = Senga.where(:user_id => params[:user_id]).order(created_at: :desc).page(params[:page]).per(8)

    #線画お気に入りリスト
    elsif params[:type] && params[:type] == 'senga_like'
      @pictures = Senga.joins(:senga_likes).where(senga_likes:{user_id: current_user.id}).order(created_at: :desc).page(params[:page]).per(8)

    #完成品お気に入りリスト
    elsif params[:type] && params[:type] == 'paint_like'
      @pictures = Paint.joins(:paint_likes).where(paint_likes:{user_id: current_user.id}).order(created_at: :desc).page(params[:page]).per(8)
    
    #申請リスト
    elsif params[:type] && params[:type] == 'requests'
      #@pictures = Senga.joins(:senga_requests).where(senga_requests:{user_id: current_user.id}).where.not(senga_requests:{permission: false}).where.not(senga_requests:{permission: true}).order(created_at: :desc).page(params[:page]).per(6)
      @pictures = Senga.joins(:senga_requests).where(senga_requests:{user_id: current_user.id,permission: nil}).order(created_at: :desc).page(params[:page]).per(8)
    
    #許可済み知スト
    elsif params[:type] && params[:type] == 'permitted'
      @pictures = Senga.joins(:senga_requests).where(senga_requests:{user_id: current_user.id,permission: true}).order(created_at: :desc).page(params[:page]).per(8)
    
    #カテゴリー検索リスト
    elsif params[:type] && params[:type] == 'category'
      @pictures = Senga.joins(:senga_categories).where(senga_categories:{category_id: params[:category]}).order(created_at: :desc).page(params[:page]).per(8)
    
    
    #線画のいいね順
    elsif params[:type] && params[:type] == 'senga_rank'
      senga_like_count = Senga.joins(:senga_likes).group(:senga_id).count
      senga_liked_ids = Hash[senga_like_count.sort_by{ |_, v| -v }].keys
      #oder
      @pictures = Senga.where(id: senga_liked_ids).page(params[:page]).per(8)
      
      @pictures = Senga.joins(:senga_likes).group("categories.name").order('count_all DESC').count
    
    #完成品のいいね順
    elsif params[:type] && params[:type] == 'paint_rank'
      paint_like_count = Paint.joins(:paint_likes).group(:paint_id).count
      paint_liked_ids = Hash[paint_like_count.sort_by{ |_, v| -v }].keys
      @pictures = Paint.where(id: paint_liked_ids).page(params[:page]).per(8)
    
    else
      #線画リスト
      @pictures = Senga.all.order(created_at: :desc).page(params[:page]).per(8)

    end
    
    if params[:word].present?
     @pictures = Senga.where("caption like ?", "%#{params[:word]}%").order("id desc")
     render template: 'common/list'
    else
      render template: 'common/list'
    end
    
  end
  
  #pngファイルの生成
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
