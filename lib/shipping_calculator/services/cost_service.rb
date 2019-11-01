module CostService
  module_function

  def calculate(origin, destination, weight)
    cost_formula(origin, destination, weight)
  end

  def cost_formula(origin, destination, weight)
    km_distance = distance(origin, destination)

    km_distance * weight * 0.15
  end

  def distance(origin, destination)
    _, distance = DijkstraGraph.new(formatted_distances).shortest_path(origin, destination)

    distance.is_a?(Integer) ? distance : 0
  end

  def formatted_distances
    DistanceRepository.new.all.map { |distance| [distance.origin, distance.destination, distance.kilometers] }
  end

  private_class_method :cost_formula, :distance, :formatted_distances
end
