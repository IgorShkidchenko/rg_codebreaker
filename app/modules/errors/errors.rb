# frozen_string_literal: true

module Errors
  class CoverError < StandardError
    def initialize
      super('Improper size')
    end
  end

  class IncludeError < StandardError
    def initialize
      super('Not include in propose inputs')
    end
  end

  class SizeError < StandardError
    def initialize
      super('Invalid size')
    end
  end
end
