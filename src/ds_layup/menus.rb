# frozen_string_literal: true

module DS
module LayUp

  require 'english.rb'

  module Menus
    @parameters = Parameters.new

    unless file_loaded?(__FILE__)

      menu_extensions = UI.menu('Extensions')
      menu_frameup = menu_extensions.add_submenu('LayUp')
      menu_frameup.add_item('Preferences') { show_parameters_dialog }

      UI.add_context_menu_handler do |context_menu|
        context_menu_layup = context_menu.add_submenu('LayUp')
        # cmd = UI::Command.new('Layout Panel') { layout_panel }
        cmd = UI::Command.new('Layout Panel') { show_parameters_dialog }
        cmd.menu_text = 'Layout Panel'
        # cmd.small_icon = 'icons/foo.png'
        # cmd.status_bar_text = 'foo'
        cmd.set_validation_proc do
          selection_valid?(Sketchup.active_model.selection) ? MF_ENABLED : MF_GRAYED
        end
        context_menu_layup.add_item cmd
      end
      file_loaded(__FILE__)
    end

    def self.show_parameters_dialog
      dialog_pars = @parameters.dialog_parameters
      constants = @parameters.constants

      defs = read_defaults
      defs = @parameters.defaults if defs.nil?
      inputs = UI.inputbox(@parameters.prompts, defs, @parameters.lists, 'LayUp Preferences')
      return unless inputs

      input = inputs[0]
      par = dialog_pars[:stud_depth]
      par.value = @parameters.stud_depths.key(input)
      par.default = input

      @parameters.update
      save_defaults
      layout_panel
    end

    def self.save_defaults
      Sketchup.active_model.set_attribute('layup_defaults', :layup_defaults, @parameters.defaults)
      # p read_defaults
    end

    def self.read_defaults
      Sketchup.active_model.get_attribute('layup_defaults', :layup_defaults)
    end

    def self.layout_panel
      model = Sketchup.active_model
      model.start_operation('Layout', true)
      model.commit_operation
    end

    def self.selection_valid?(selection)
      return true unless selection.length > 1
    end

    def self.test
      p read_defaults
      # remove_defaults
      # p read_defaults
    end
  end
end
end
