# frozen_string_literal: true

module Benchmark
  module Metrics
    # put metrics generated from `run_benchmarks` to cloudwatch
    def self.put_metric(client:, dims:, timestamp:, metric_name:, value:)
      return unless value.is_a?(Numeric) || value.is_a?(Array)

      # attempt to determine unit
      unit_suffix = metric_name.split('_').last
      unit = {
        'kb' => 'Kilobytes',
        'b' => 'Bytes',
        's' => 'Seconds',
        'ms' => 'Milliseconds'
      }.fetch(unit_suffix, 'None')

      metric_data = {
        metric_name: metric_name,
        timestamp: timestamp,
        unit: unit,
        dimensions: dims.map { |k, v| { name: k.to_s, value: v } }
      }

      case value
      when Numeric
        metric_data[:value] = value
        client.put_metric_data(namespace: 'hearth-performance', metric_data: [metric_data])
      when Array
        # cloudwatch has a limit of 150 values
        value.each_slice(150) do |values|
          metric_data[:values] = values
          client.put_metric_data(namespace: 'hearth-performance', metric_data: [metric_data])
        end
      else
        raise 'Unknown type for metric value'
      end
    end
  end
end
