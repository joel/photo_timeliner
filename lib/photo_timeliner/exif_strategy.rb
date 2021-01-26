# frozen_string_literal: true

require 'forwardable'

module PhotoTimeliner
  class ExifStrategy
    extend Forwardable

    # delegate :call, to: :strategy
    def_delegators :strategy, :call

    def initialize(media_path)
      @media_path = media_path
    end

    private

    attr_reader :media_path

    def strategy
      @strategy ||= strategy_selector.new(media_path)
    end

    class ExifStrategyError < StandardError; end

    def strategy_selector
      case options.exif_strategy.to_sym
      when :basic then ExifBasic
      when :virtual then ExifVirtual
      when :system then ExifSystem
      else
        raise ExifStrategyError, "Unknown exif strategy [#{options.exif_strategy}]"
      end
    end

    def options
      PhotoTimeliner.configuration.options
    end
  end
end
