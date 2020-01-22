class UsersController < ApplicationController

  def sign_up
  end
  
  # ユーザー登録処理
  def sign_up_process
    user = User.new(user_params)
    if user.save
     # 登録が成功したらサインインしてトップページへ
      user_sign_in(user)
      redirect_to root_path
    else
      # 登録が失敗したらユーザー登録ページへ
      flash[:danger] = "ユーザー登録に失敗しました。"
      redirect_to sign_up_path and return
    end
  end

  def sign_in
  end

  def sign_in_process
    user = User.find_by(:email => user_params[:email])
    if user && user.authenticate(user_params[:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:danger] = "サインインに失敗しました。"
      redirect_to sign_in_path and return
    end
  end
  
  # サインアウト
  def sign_out
    
    # ユーザーセッションを破棄
    user_sign_out
    
    # サインインページへ遷移
    redirect_to sign_in_path and return
    
  end

  # サインアウトする
  def user_sign_out
    session.delete(:user_id)
    @current_user = nil
  end
  
#プロフィール関連---------------------------------------
  
  # プロフィールページ
  def profile
    #データ取得
    @user = User.find(params[:id])
    
    #最新の線画表示
    @senga = Senga.where(user_id: @user.id ).limit(4)
    #全ての線画表示
    @senga_all = Senga.where(user_id: @user.id )
    
    #最新の完成品表示
    @paint = Paint.where(user_id: @user.id ).limit(4)
    #全ての完成品表示
    @paint_all = Paint.where(user_id: @user.id )
  end
  
  def profile_edit
    
  end
  
  def update
    current_user.update(user_params)
    redirect_to profile_path(current_user)
  end
  
#--------------------------------------------------------------
  
  private
  
  def user_params
    params.require(:user).permit(:email,:password,:name,:image)
  end
end
