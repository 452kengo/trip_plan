class PlansController < ApplicationController
  before_action :authenticate_user!
  before_action :set_plan, only: %i[ show edit update destroy ]

  # GET /plans or /plans.json
  def index
    @plans = current_user.Plan.all
  end

  # GET /plans/1 or /plans/1.json
  def show
  end

  # GET /plans/new
  def new
    @plan = current_user.Plan.new
  end

  # GET /plans/1/edit
  def edit
  end

  # POST /plans or /plans.json
  def create
    @plan = current_user.Plan.new(plan_params)

    respond_to do |format|
      if @plan.save
        @status = true
        format.json { render :show, status: :created, location: @plan }
      else
        @status = false
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plans/1 or /plans/1.json
  def update
    respond_to do |format|
      if @plan.update(plan_params)
        @status = true
        format.json { render :show, status: :ok, location: @plan }
      else
        @status = false
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plans/1 or /plans/1.json
  def destroy
    @plan.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plan
      @plan = current_user.Plan.find(params[:id])
      redirect_to(plans_url, alert: "ERROR!!") if @plan.blank?
    end

    # Only allow a list of trusted parameters through.
    def plan_params
      params.require(:plan).permit(:title, :plan_date)
    end
end
