# frozen_string_literal: true
module PhotoTimeliner
  class Logger
    def info(msg)
      return unless PhotoTimeliner.configuration.verbose

      puts(msg)
    end
  end
end
