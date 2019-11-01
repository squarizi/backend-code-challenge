module Api
  module Controllers
    module Distance
      class Receive
        include Api::Action

        before :organize_params

        def call(params)
          return error unless validator.success?

          find_distance ? update_distance : create_distance
        end

        private

        def organize_params(params)
          @origin, @destination, @kilometers = params.raw&.keys&.first&.split(' ')
        end

        def validator
          @validator ||= DistanceValidator.new(origin: @origin, destination: @destination, kilometers: @kilometers.to_i).validate
        end

        def error
          content(422, validator.errors)
        end

        def content(status_code, message)
          status status_code, { message: message }.to_json
        end

        def repository
          @repository ||= DistanceRepository.new
        end

        def find_distance
          @distance_id ||= repository.find_id_by_origin_and_destination(@origin, @destination)
        end

        def create_distance
          content(201, 'Created') if repository.create(origin: @origin, destination: @destination, kilometers: @kilometers.to_i)
        end

        def update_distance
          content(200, 'Updated') if repository.update(@distance_id, kilometers: @kilometers.to_i)
        end
      end
    end
  end
end
