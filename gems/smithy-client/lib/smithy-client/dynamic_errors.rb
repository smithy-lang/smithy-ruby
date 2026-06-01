# frozen_string_literal: true

module Smithy
  module Client
    # This module is mixed into generated Errors modules, providing dynamic
    # error classes. Error classes all inherit from {ServiceError}.
    #
    #     # Creates and returns the class
    #     Weather::Errors::MyNewErrorClass
    #
    # Since the complete list of possible errors returned by services may
    # not be known, this allows us to create them as needed. This also
    # allows users to rescue errors by class without them being concrete
    # classes beforehand.
    #
    # @api private
    module DynamicErrors
      def self.extended(submodule)
        submodule.instance_variable_set('@const_set_mutex', Mutex.new)
        submodule.const_set(:ServiceError, Class.new(ServiceError))
      end

      def const_missing(constant)
        set_error_constant(constant)
      end

      # Given the name of a service and an error code, this method
      # returns an error class that extends {ServiceError}.
      #
      #     Weather::Errors.error_class('NoSuchCity').new
      #     #=> #<Weather::Errors::NoSuchCity>
      #
      # @api private
      def error_class(error_code)
        constant = error_class_constant(error_code)
        if error_const_set?(constant)
          err_class = const_get(constant)
          err_class.code = constant.to_s
          err_class
        else
          set_error_constant(constant)
        end
      end

      private

      # Convert an error code to an error class name/constant.
      # This requires filtering non-safe characters from the constant
      # name and ensuring it begins with an uppercase letter.
      #
      # @param [String] error_code
      # @return [Symbol] Returns a symbolized constant name for the given `error_code`.
      def error_class_constant(error_code)
        constant = error_code.to_s
        constant = constant.gsub(/[^a-zA-Z0-9]/, '')
        constant = "Error#{constant}" unless constant.match(/^[a-z]/i)
        constant = constant[0].upcase + constant[1..]
        constant.to_sym
      end

      def set_error_constant(constant) # rubocop:disable Naming/AccessorMethodName
        @const_set_mutex.synchronize do
          # Ensure the const was not defined while blocked by the mutex
          if error_const_set?(constant)
            const_get(constant)
          else
            error_class = Class.new(const_get(:ServiceError))
            error_class.code = constant.to_s
            const_set(constant, error_class)
          end
        end
      end

      def error_const_set?(constant)
        # Purposefully not using #const_defined? as that method returns true
        # for constants not defined directly in the current module.
        const_defined?(constant.to_sym)
      end
    end
  end
end
