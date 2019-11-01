class DistanceRepository < Hanami::Repository
  def find_id_by_origin_and_destination(origin, destination)
    distances.select(:id).where(origin: origin, destination: destination).one&.id
  end
end
