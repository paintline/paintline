class PaintsController < ApplicationController
        
    def paint_like
        # find_by 特定の値を検索、user_idがcurrent_user.idでありsenga_idがparams[:id]である時に実行
        if PaintLike.find_by(:user_id => current_user.id , :paint_id => params[:id] )
            
            # paint_likeのuser_idがcurrent_user.idでありsenga_idがparams[:id]である時
            paint_like = PaintLike.find_by(:paint_id => params[:id],:user_id => current_user.id )
            #
            paint_like.destroy
            redirect_back(fallback_location: root_path, notice: "お気に入り削除しました")
            
        else
            
            paint_like = PaintLike.new(:paint_id => params[:id],:user_id => current_user.id )
            if paint_like.save
            # 成功
              redirect_back(fallback_location: root_path, notice: "お気に入り登録しました")
              
            else
              # 失敗
              flash[:danger] = "お気に入り登録に失敗しました。"
              redirect_to sengas_path 
              
            end
        end
    end
    
    def show
        #sengaテーブルからIDを取得
        @paint = Paint.find(params[:id])
    end
    
    # 投稿処理
    def create
        
        # 線画のデータを登録する(.new)
        paint = Paint.new(paint_params)
        
        if paint_params[:image]
            
            # PSDファイルじゃなかった場合
            if paint_params[:image].original_filename.split('.')[1] != 'psd'
                flash[:danger] = "psdデータを投稿してください。"
                redirect_to paints_path and return
            end
         
            # 線画のデータをテーブルに保存する
            if paint.save!
                
                # カテゴリーを登録
                if params[:categories]
                    params[:categories].each do |c|
                        paint.paint_categories.create(:category_id => c)
                    end
                end
                
                # PSDファイルの場合
                if File.basename(paint.image.url).split('.')[1] == 'psd'
                    require 'psd'
                    @psd = PSD.new(Rails.root.to_s + '/public' + paint.image.url)
                    @psd.parse!
                    @psd.image.save_as_png Rails.root.to_s + '/public' + paint.image.url + '.png'
                    flash[:succsess] = "画像投稿しました"
                    redirect_to paint_path(paint.id)
                end
                
            # 失敗
            else
                flash[:danger] = "投稿に失敗しました"
                redirect_to paints_path 
            end
        
        else
            flash[:danger] = "ファイルを選択してください。"
            redirect_to paints_path 
        end
    end

    private
    
    def paint_params
        params.require(:paint).permit(:image,:description,:senga_id).merge(user_id: current_user.id)
    end
end

