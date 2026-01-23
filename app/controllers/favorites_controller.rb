class FavoritesController < ApplicationController
  before_action :set_api_service, only: [:index]

  def index
    @favorites = current_user.favorites.order(created_at: :desc)
    fixture_ids = @favorites.pluck(:fixture_id)

    @matches = []
    fixture_ids.each do |fixture_id|
      result = @api_service.fixture(fixture_id)
      match = result["response"]&.first
      @matches << match if match
    end

    @using_dummy_data = @api_service.using_dummy_data?
  end

  def create
    @favorite = current_user.favorites.build(fixture_id: params[:fixture_id])
    if @favorite.save
      respond_to do |format|
        format.html { redirect_back fallback_location: root_path, notice: "お気に入りに追加しました" }
        format.turbo_stream
      end
    else
      redirect_back fallback_location: root_path, alert: "お気に入りに追加できませんでした"
    end
  end

  def destroy
    @favorite = current_user.favorites.find_by(fixture_id: params[:fixture_id])
    if @favorite&.destroy
      respond_to do |format|
        format.html { redirect_back fallback_location: root_path, notice: "お気に入りから削除しました" }
        format.turbo_stream
      end
    else
      redirect_back fallback_location: root_path, alert: "お気に入りから削除できませんでした"
    end
  end

  private

  def set_api_service
    @api_service = FootballApiService.new
  end
end
