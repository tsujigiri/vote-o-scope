class PartiesController < ApplicationController
  load_and_authorize_resource
  respond_to :json, only: :index

  def index
    respond_with @parties
  end

  def new
    @party = Party.new
  end

  def edit
  end

  def update
    @party.update(party_params)
    respond_with @party, location: parties_path
  end

  def destroy
    @party.destroy
    respond_with @party, location: parties_path
  end

  private

  def party_params
    params.require(:party).permit!
  end
end
