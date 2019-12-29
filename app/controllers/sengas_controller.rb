class SengasController < ApplicationController
    
    def index

    end
    
    def create
         #線画のデータを登録する(.new)
         senga = Senga.new(senga_params)
         
         #線画のデータをテーブルに保存する
         if senga.save
          if params[:categories]
            params[:categories].each do |c|
              senga.senga_categories.create(:category_id => c)
            end
          end
          
          if File.basename(senga.image.url).split('.')[1] != 'psd'
          flash[:danger] = "psdデータを投稿してください。"
          redirect_to sengas_path and return
          end
          
          # 成功
          #senga = Senga.find(params[:id])
          require 'psd'
          @psd = PSD.new('/home/ec2-user/environment/paintline/public' + senga.image.url)
          @psd.parse!
          @psd.image.save_as_png '/home/ec2-user/environment/paintline/public' + senga.image.url + '.png'
          
          flash[:succsess] = "画像投稿しました"
          redirect_to root_path
        
        #失敗した時
         else
          # 失敗
          flash[:danger] = "投稿に失敗しました。"
          redirect_to sengas_path 
         end
        
    end
    
    def show
        #sengaテーブルからIDを取得
        @senga = Senga.find(params[:id])
    end
    
    def senga_like
        # find_by 特定の値を検索、user_idがcurrent_user.idでありsenga_idがparams[:id]である時に実行
        if SengaLike.find_by(:user_id => current_user.id , :senga_id => params[:id] )
            
            # senga_likeのuser_idがcurrent_user.idでありsenga_idがparams[:id]である時
            senga_like = SengaLike.find_by(:senga_id => params[:id],:user_id => current_user.id )
            #
            senga_like.destroy
            redirect_back(fallback_location: root_path, notice: "お気に入り削除しました")
            
        else
            
            senga_like = SengaLike.new(:senga_id => params[:id],:user_id => current_user.id )
            if senga_like.save
            # 成功
              redirect_back(fallback_location: root_path, notice: "お気に入り登録しました")
              
            else
              # 失敗
              flash[:danger] = "お気に入り登録に失敗しました。"
              redirect_to sengas_path 
              
            end
        end
    end
    
    
    #申請
    def senga_request
        senga_request = SengaRequest.find_by(:user_id => current_user.id, :senga_id => params[:senga_id])
        
        if senga_request
          senga_request.destroy
          
        else
          SengaRequest.create(:user_id => current_user.id, :senga_id => params[:senga_id])

        end
        redirect_to senga_path(params[:senga_id])
    end
    
    #許可
    def senga_request_commit
        senga_request = SengaRequest.find(params[:request_id])
        
        if senga_request.senga.user_id == current_user.id
            if senga_request.permission != true
              senga_request.permission = true
              senga_request.save
              
            else 
              senga_request.permission = false
              senga_request.save
              
            end
        end
        redirect_to senga_path(senga_request.senga_id)
    end
    
    #不許可
    def senga_request_deny
        senga_request = SengaRequest.find(params[:request_id])

        senga_request.permission = false
        senga_request.save
              
        redirect_to senga_path(senga_request.senga_id)
    end


    private
    
    def senga_params
        params.require(:senga).permit(:image,:tittle,:description).merge(user_id: current_user.id)
    end
end
