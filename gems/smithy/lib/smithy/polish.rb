# frozen_string_literal: true

module Smithy
  # A base class that must be inherited from by all polish classes. Includes thor and hooks for
  # modifying the generated code.
  class Polish
    include Thor::Base
    include Thor::Actions

    # @param [Plan] plan The plan that is being executed.
    def initialize(plan)
      @plan = plan
      # Necessary for Thor::Base and Thor::Actions
      self.options = { force: true }
      self.destination_root = plan.options[:destination_root]
    end

    # Called to determine if the polish should be applied for this model.
    # @param [Hash] model
    # @return [Boolean] (true) True if the polish should be applied, false otherwise.
    def for?(model)
      true
    end

    # Called after the artifact is generated.
    # @param artifact [Enumerator<String, String>] The artifact that was generated.
    #  The key is the path of the file and the value is the content of the file.
    def polish(artifact)
      # no-op
    end
  end
end
