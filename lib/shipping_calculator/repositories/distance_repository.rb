class DistanceRepository < Hanami::Repository
  def find_id_by_origin_and_destination(origin, destination)
    distances.select(:id).where(origin: origin, destination: destination).one&.id
  end

  def origin_or_destination_exist?(origin, destination)
    sql = Sequel.lit("origin = ? or destination = ?", origin, destination)

    distances.select(:id).where(sql).exist?
  end
end
