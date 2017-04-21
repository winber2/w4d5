class GoalsController < ApplicationController
  def new
    @goal = Goal.new
    render :new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id if current_user

    if @goal.save
      render :show
    else
      flash[:errors] = ['Your Goal is mediocre, bruh']
      redirect_to new_goal_url
    end
  end

  def edit
    @goal = Goal.find_by(id: params[:id])
    render :edit
  end

  def update
    @goal = Goal.find_by(name: params[:goal][:name])

    if @goal.update_attributes(goal_params)
      render :show
    else
      flash[:errors] = ['Your updated Goal is too mediocre']
      redirect_to goal_url(@goal)
    end
  end

  def destroy
    @goal = Goal.find_by(id: params[:id],)

    if @goal
      @goal.destroy
      redirect_to user_url(@goal.user_id)
    else
      flash[:errors] = ['DON\'T FUCK UP MAH SITE']
      redirect_to users_url
    end
  end

  private

  def goal_params
    params.require(:goal).permit(:name, :body)
  end

end
