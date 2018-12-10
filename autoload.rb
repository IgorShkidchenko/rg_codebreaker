# frozen_string_literal: true

require 'i18n'
require 'yaml'
require_relative './app/modules/uploader/uploader'
require_relative './app/modules/validator/validator'
require_relative './app/entities/validatable_entity'
require_relative './app/entities/navigator'
require_relative './app/entities/representer'
require_relative './app/entities/game'
require_relative './app/entities/console'
require_relative './app/entities/statistics_result'
require_relative './app/entities/user'
require_relative './app/entities/difficult'
require_relative './app/entities/guess'
I18n.load_path << Dir[File.expand_path('locales') + '/*.yml']
