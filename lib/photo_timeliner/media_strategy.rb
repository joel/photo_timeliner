# frozen_string_literal: true

module PhotoTimeliner
  class MediaStrategy
    private

    def strategy
      @strategy ||= strategy_selector
    end

    class MediaStrategyError < StandardError; end

    def strategy_selector
      case options.media.to_sym
      when :image then ImageStrategy
      when :video then VideoStrategy
      else
        raise MediaStrategyError, "Unknown media strategy [#{options.media}]"
      end
    end

    def options
      PhotoTimeliner.configuration.options
    end
  end
end
