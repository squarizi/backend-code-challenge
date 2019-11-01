module Api
  module Controllers
    module Distance
      class Receive < Api::Controllers::Base
        include Api::Action

        before :organize_params

        def call(params)
          return validate_error unless validator.success?

          find_distance ? update_distance : create_distance
        end

        private

        def organize_params(params)
          @origin, @destination, @kilometers = params.raw&.keys&.first&.split(' ')
        end

        def validator
          @validator ||= DistanceValidator.new(origin: @origin, destination: @destination, kilometers: @kilometers.to_i).validate
        end

        def find_distance
          @distance_id ||= repository.find_id_by_origin_and_destination(@origin, @destination)
        end

        def create_distance
          repository.create(origin: @origin, destination: @destination, kilometers: @kilometers.to_i)
          created
        rescue Exception => e
          error(e.inspect)
        end

        def update_distance
          repository.update(@distance_id, kilometers: @kilometers.to_i)
          updated
        rescue Exception => e
          error(e.inspect)
        end
      end
    end
  end
end
