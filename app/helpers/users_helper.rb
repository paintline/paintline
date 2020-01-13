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
  
  # プロフィール画像がなかったらダミー画像を指定する
  def image_url(user)
    if user.image.blank?
      "https://dummyimage.com/200x200/000/fff"
    else
      "#{user.image}"
    end
  end
  
end
