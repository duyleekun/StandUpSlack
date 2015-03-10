class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy, :send_digest, :send_prompt]

  # GET /teams
  def index
    @teams = Team.all
  end

  # GET /teams/1
  def show
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  def send_prompt
    text = render_to_string(:formats => [:text], locals: {team: @team })
    @team.users.where(daily_prompt_active: true).includes(:team).each do |user|
      user.send_im(text)
    end
    render json: {success: true}
  end

  def send_digest
    @team.update_users
    @team.users.includes(:team).each(&:fetch_tasks)
    text = render_to_string(:formats => [:text], locals: {team: @team})
    @team.users.where(daily_digest_enabled: true).includes(:team).each do |user|
      user.send_im(text)
    end
    render json: {success: true}
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams
  def create
    @team = Team.new(team_params)

    if @team.save
      redirect_to @team, notice: 'Team was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /teams/1
  def update
    if @team.update(team_params)
      redirect_to @team, notice: 'Team was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /teams/1
  def destroy
    @team.destroy
    redirect_to teams_url, notice: 'Team was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def team_params
      params.require(:team).permit(:name, :token)
    end
end
