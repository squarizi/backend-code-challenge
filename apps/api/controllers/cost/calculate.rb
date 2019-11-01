module Api
  module Controllers
    module Cost
      class Calculate < Api::Controllers::Base
        include Api::Action

        before :organize_params

        def call(params)
          return validate_error unless validator.success?
          return parameters_error unless origin_or_destination_exist?
        end

        private

        def organize_params(params)
          @origin, @destination, @weight = params[:origin], params[:destination], params[:weight].to_i
        end

        def validator
          @validator ||= CostValidator.new(origin: @origin, destination: @destination, weight: @weight).validate
        end

        def origin_or_destination_exist?
          repository.origin_or_destination_exist?(@origin, @destination)
        end

        def parameters_error
          error('origin or destination does not exists')
        end
      end
    end
  end
end
