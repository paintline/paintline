class PaintsController < ApplicationController
        
    def index
        @paints = Paint.new
        # find_by 特定の値を検索、user_idがcurrent_user.idでありsenga_idがparams[:id]である時に実行
        if SengaLike.find_by(:user_id => current_user.id , :senga_id => params[:id] )
 
        else
            
            senga_like = SengaLike.new(:senga_id => params[:senga_id],:user_id => current_user.id )
            if senga_like.save
            # 成功
              
            else
              # 失敗
              flash[:danger] = "お気に入り登録に失敗しました。"
            end
        end
    end
    
    def create
         paint = Paint.new(paint_params)
         
         if paint.save
             # 成功
            flash[:succsess] = "画像投稿しました"
        
        redirect_to root_path
        
         else
          # 失敗
          flash[:danger] = paint.errors.full_messages
          redirect_to sengas_path 
         end
    end

    private
    
    def paint_params
        params.require(:paint).permit(:image,:description,:senga_id).merge(user_id: current_user.id)
    end
end

