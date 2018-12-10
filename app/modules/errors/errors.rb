# frozen_string_literal: true

module Errors
  class CoverError < StandardError
    def initialize
      super(I18n.t('exceptions.covererror'))
    end
  end

  class IncludeError < StandardError
    def initialize
      super(I18n.t('exceptions.includeerror'))
    end
  end

  class SizeError < StandardError
    def initialize
      super(I18n.t('exceptions.sizeerror'))
    end
  end
end
