# frozen_string_literal: true

require 'i18n'
require 'yaml'
require_relative './modules/console/uploader'
require_relative './modules/console/validator'
require_relative './entities/representer'
require_relative './entities/game'
require_relative './entities/console'
require_relative './entities/statistics_result'
require_relative './entities/user'
I18n.load_path << Dir[File.expand_path('locales') + '/*.yml']
