class PlansController < ApplicationController
  before_action :authenticate_user!
  before_action :set_plan, only: %i[ show edit update destroy ]

  # GET /plans or /plans.json
  def index
    @plans = current_user.plans.all.order("plan_date DESC")
  end

  # GET /plans/1 or /plans/1.json
  def show
  end

  # GET /plans/new
  def new
    @plan = current_user.plans.new
  end

  # GET /plans/1/edit
  def edit
  end

  # POST /plans or /plans.json
  def create
    @plan = current_user.plans.new(plan_params)

      if @plan.save
        @status = true
      else
        @status = false
      end
  end

  # PATCH/PUT /plans/1 or /plans/1.json
  def update
    if @plan.update(plan_params)
      @status = true
    else
      @status = false
    end
  end

  # DELETE /plans/1 or /plans/1.json
  def destroy
    @plan.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plan
      @plan = current_user.plans.find_by(id: params[:id])
      redirect_to(plans_url, alert: "ERROR!!") if @plan.blank?
    end

    # Only allow a list of trusted parameters through.
    def plan_params
      params.require(:plan).permit(:title, :plan_date, :user_id)
    end
end
