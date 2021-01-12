# frozen_string_literal: true

require 'zeitwerk'
loader = Zeitwerk::Loader.for_gem
loader.setup
module PhotoTimeliner
  class Main
    def photo_timeliner(input)
      input
    end
  end

  class Error < StandardError; end
end
