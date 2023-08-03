

valid_range = {
  :min => 0,
  :max => true
}

valid_range.each_value {|value| validate_types!(value, Integer, )}


def validate_types!(value, *types, context:)
  return if !value || types.any? { |type| value.is_a?(type) }

  raise ArgumentError,
        "Expected #{context} to be in " \
        "[#{types.map(&:to_s).join(', ')}], got #{value.class}."
end


validate_types!('foo', Integer, context: 'number')

valid_range.each {|key, value| validate_types!(value, Integer, context: key )}


def validate_range(value, valid_range, context:)

  return if value.between?(valid_range[:min], valid_range[:max])

  raise ArgumentError,
        "Expected #{context} to be between " \
        "#{minimum} to #{maximum}, got #{value}."
end

validate_range(2, valid_range, context: 'number')
validate_range(21, valid_range, context: 'number')
