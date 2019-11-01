class CostValidator
  include Hanami::Validations

  validations do
    required(:origin) { filled? & str? & size?(1..60) }
    required(:destination) { filled? & str? & size?(1..60) }
    required(:weight) { filled? & int? & gt?(0) & lteq?(50) }
  end
end
