# frozen_string_literal: true

module Errors
  class CoverError < StandardError
    def initialize
      super(I18n.t('exceptions.cover_error'))
    end
  end

  class IncludeError < StandardError
    def initialize
      super(I18n.t('exceptions.include_error'))
    end
  end

  class SizeError < StandardError
    def initialize
      super(I18n.t('exceptions.size_error'))
    end
  end
end
