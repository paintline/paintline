class ProfileController < ApplicationController
    
  # プロフィールページ
  def show
    #データ取得
    @user = User.find(params[:id])
    @product = Product.where(user_id: current_user.id)
  end
    
end
