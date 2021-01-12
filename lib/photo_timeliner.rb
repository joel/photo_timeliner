# frozen_string_literal: true

require 'zeitwerk'
loader = Zeitwerk::Loader.for_gem
loader.setup

def log(msg)
  PhotoTimeliner.configuration.logger.info(msg)
end

require 'json'

module PhotoTimeliner
  extend Configure
  class Main
    def call
      collection.each do |image_path|
        log("Reading... [#{File.basename(image_path).downcase}]")
        info = { image_path: image_path }.to_json
        info = JSON.parse(info).transform_keys(&:to_sym)
        ImageHandler.new(**info).copy
      end

      nil
    end

    private

    def collection
      Dir.glob("#{options.source_directory}/**/*.{jpg,jpeg}")
    end

    def options
      PhotoTimeliner.configuration.options
    end
  end

  class Error < StandardError; end
end
