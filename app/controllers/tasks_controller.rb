class TasksController < ApplicationController
    before_action :require_user_logged_in
    before_action :correct_user, only: [:show, :edit, :update, :destroy]
    
    def index
       @tasks = current_user.tasks 
    end
    
    def show
    end

    def new
        @task = Task.new
    end
    
    def create
        @task = current_user.tasks.build(task_params)
        
        if @task.save
            flash[:success] = 'Taskの作成に成功しました'
            redirect_to @task
        else
            @tasks = current_user.tasks.order(id: :desc).page(params[:page])
            flash.now[:danger] = 'Taskの作成に失敗しました'
            render 'toppages/index'
        end
    end
    
    def edit
    end

    def update
        if @task.update(task_params)
            flash[:success] = 'Taskの更新に成功しました'
            redirect_to @task
        else
            flash.now[:danger] = 'Taskの更新に失敗しました'
            render :new
        end
    end
    
    def destroy
        @task.destroy
        
        flash[:success] = 'Taskの削除に成功しました'
        redirect_back(fallback_location: root_path)
    end
    
    private
    
    def task_params
       params.require(:task).permit(:content, :status) 
    end
    
    def correct_user
        @task = current_user.tasks.find_by(id: params[:id])
        unless @task
            redirect_to root_url
        end
    end
end
