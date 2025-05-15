class TrimestersController < ApplicationController
  before_action :set_trimester, only: %i[show edit update]
  before_action :validate_trimester, only: :update
  before_action :validate_application_deadline, only: :update
  def index
    @trimesters = Trimester.all
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @trimester.update(trimester_params)
        format.html { redirect_to trimesters_path, notice: 'Trimester was successfully updated.' }
        format.json { render :show, status: :ok, location: @trimester }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @trimester.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_trimester
    @trimester = Trimester.find(params[:id])
  end

  def trimester_params
    params.require(:trimester).permit(
      :max_enrollment,
      :year,
      :term,
      :application_deadline,
      :start_date,
      :end_date
    )
  end

  def validate_trimester
    return if @trimester

    respond_to do |format|
      format.html { redirect_to trimesters_path, notice: 'Trimester not found.' }
      format.json { render json: { error: 'Trimester not found' }, status: :not_found }
    end
    nil
  end

  def validate_application_deadline
    deadline = params.dig(:trimester, :application_deadline)
    if deadline.blank?
      @trimester.assign_attributes(trimester_params)
      flash.now[:alert] = 'Application deadline is required.'
      respond_to do |format|
        format.html { render :edit }
        format.json { render json: { error: 'Application deadline is required' }, status: :bad_request }
      end
      return
    end

    begin
      Date.parse(deadline)
    rescue ArgumentError
      @trimester.assign_attributes(trimester_params)
      flash.now[:alert] = 'Invalid application deadline'
      respond_to do |format|
        format.html { render :edit }
        format.json { render json: { error: 'Invalid application deadline' }, status: :bad_request }
      end
      nil
    end
  end
end
