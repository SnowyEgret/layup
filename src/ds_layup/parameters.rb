# frozen_string_literal: true

module DS
module LayUp

  Sketchup.require(File.join(PLUGIN_DIR, 'parameter'))

  class Parameters
    attr_accessor(
      :dialog_parameters,
      :constants,
      :parameters,
      :foo_values
    )

    def initialize
      @foo_values =
        {
          1 => 'one',
          2 => 'two'
        }

      # Each entry will appear in the dialog_parameters dialog for setting
    @dialog_parameters =
        {
          foo: Parameter.new('Foo:', @foo_values)
        }

      # Dimensions which are not set in the dialog
      # Sheathing and drywall thicknesses are here because their change is implied
      # by type which is set above
      @constants =
        {
          bar: 96
        }

      @parameters = merge_dialog_parameters_and_constants
    end

    def merge_dialog_parameters_and_constants
      pars = {}
      @dialog_parameters.each_pair do |key, par|
        pars[key] = par.value
      end
      pars.merge! @constants
      pars
    end

    def update
      @parameters = merge_dialog_parameters_and_constants
    end

    def prompts
      prompts = []
      @dialog_parameters.values.each do |par|
        prompts << par.prompt
      end
      prompts
    end

    def defaults
      defs = []
      @dialog_parameters.values.each do |par|
        defs << par.default
      end
      defs
    end

    def lists
      lists = []
      @dialog_parameters.values.each do |par|
        lists << par.list
      end
      lists
    end

    def self.test
      pars = Parameters.new
      # p pars.dialog_parameters
      # p pars.constants
      p pars.parameters
    end
  end
end
end
