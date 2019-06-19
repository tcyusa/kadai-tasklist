class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit, :update, :destroy]
    
    def index
       @tasks = Task.all 
    end
    
    def show
        set_task
    end

    def new
        @task = Task.new
    end
    
    def create
        @task = Task.new(task_params)
        
        if @task.save
            flash[:success] = 'Taskの作成に成功しました'
            redirect_to @task
        else
            flash.now[:danger] = 'Taskの作成に失敗しました'
            render :new
        end
    end
    
    def edit
        set_task
    end

    def update
        set_task
        
        if @task.update(task_params)
            flash[:success] = 'Taskの更新に成功しました'
            redirect_to @task
        else
            flash.now[:danger] = 'Taskの更新に失敗しました'
            render :new
        end
    end
    
    def destroy
        set_task
        @task.destroy
        
        flash[:success] = 'Taskの削除に成功しました'
        redirect_to tasks_url
    end
    
    private
    
    def set_task
        @task = Task.find(params[:id])
    end
    
    def task_params
       params.require(:task).permit(:content) 
    end
end
