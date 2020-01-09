class ProfileController < ApplicationController
    
  # プロフィールページ
  def show
    #データ取得
    @user = User.find(params[:id])
  end
    
end
