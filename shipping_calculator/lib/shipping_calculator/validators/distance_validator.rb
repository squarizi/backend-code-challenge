class DistanceValidator
  include Hanami::Validations

  validations do
    required(:origin) { filled? & str? & size?(1..60) }
    required(:destination) { filled? & str? & size?(1..60) }
    required(:kilometers) { filled? & int? & gt?(0) & lteq?(100000) }
  end
end
