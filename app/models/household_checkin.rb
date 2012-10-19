class HouseholdCheckin < ActiveRecord::Base
  belongs_to :household
  has_many :client_checkins

  def self.create_for(primary_client)
    household = primary_client.household
    raise InvalidAssociationError if !household
    household_checkin = household.household_checkins.create
    household.clients.each do |client|
      client.client_checkins.create(:household_checkin_id => household_checkin.id, :primary => client == primary_client, :id_warn => false)
    end
  end

  def primary_client_checkin
    client_checkins.where('client_checkins.primary IS TRUE').first
  end

  def primary_client
    primary_client_checkin.client
  end

  def clean?
    [!res_warn, !inc_warn, !gov_warn].all?
  end

  def clean_clients?
    client_checkins.map(&:clean?).all?
  end

  def totally_clean?
    clean? && clean_clients?
  end
end
