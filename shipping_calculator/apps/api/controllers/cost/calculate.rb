module Api
  module Controllers
    module Cost
      class Calculate < Api::Controllers::Base
        include Api::Action

        before :organize_params

        def call(params)
          return validate_error unless validator.success?
        end

        private

        def organize_params(params)
          @origin, @destination, @weight = params[:origin], params[:destination], params[:weight]
        end

        def validator
          @validator ||= CostValidator.new(origin: @origin, destination: @destination, weight: @weight).validate
        end
      end
    end
  end
end
