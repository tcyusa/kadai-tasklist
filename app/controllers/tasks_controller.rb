class TasksController < ApplicationController
    def index
       @tasks = Task.all 
    end
    
    def show
        @task = Task.find(params[:id])
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
        @task = Task.find(params[:id])
    end

    def update
        @task = Task.find(params[:id])
        
        if @task.update(task_params)
            flash[:success] = 'Taskの更新に成功しました'
            redirect_to @task
        else
            flash.now[:danger] = 'Taskの更新に失敗しました'
            render :new
        end
    end
    
    def destroy
        @task = Task.find(params[:id])
        @task.destroy
        
        flash[:success] = 'Taskの削除に成功しました'
        redirect_to tasks_url
    end
    
    private
    def task_params
       params.require(:task).permit(:content) 
    end
end
