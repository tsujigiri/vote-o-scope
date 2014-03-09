class PartiesController < ApplicationController
  load_and_authorize_resource

  def new
    @party = Party.new
  end

  def edit
  end

  def update
    @party.update(party_attributes)
    respond_with @party, location: parties_path
  end

  def destroy
    @party.destroy
    respond_with @party, location: parties_path
  end

  private

  def party_attributes
    params.require(:party).permit!
  end
end
