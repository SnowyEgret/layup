# Copyright 2022, Duncan Murray Swain
# All rights reserved

# License:    MIT
# Author:     Duncan Murray Swain, duncan.m.swain@gmail.com
# Repository: https://github.com/SnowyEgret/layup
# Version:    v0.1.0
# Date:       4/25/2022

require 'extensions.rb'

module DS
  module LayUp
    path = __FILE__
    path.force_encoding('UTF-8') if path.respond_to?(:force_encoding)

    PLUGIN_ID = File.basename(path, '.*')
    PLUGIN_DIR = File.join(File.dirname(path), PLUGIN_ID)
    REQUIRED_SU_VERSION = 18
    EXTENSION = SketchupExtension.new('LayUp', File.join(PLUGIN_DIR, 'main'))
    EXTENSION.creator     = 'Duncan Swain (SnowyEgret)'
    EXTENSION.description = 'Creates a Layout file'
    EXTENSION.version     = '0.1.0'
    EXTENSION.copyright   = "2022, #{EXTENSION.creator}"
    Sketchup.register_extension(EXTENSION, true)
  end
end
