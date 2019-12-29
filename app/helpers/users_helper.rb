module UsersHelper

  # 渡されたユーザーでサインインする
  def user_sign_in(user)
   session[:user_id] = user.id
  end
    
# 現在サインイン中のユーザー情報を返す
  def current_user
    if @current_user.nil?
      @current_user = User.find_by(id: session[:user_id])
    else
      @current_user
    end
  end
  
end
