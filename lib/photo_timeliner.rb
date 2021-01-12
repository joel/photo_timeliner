# frozen_string_literal: true

require 'zeitwerk'
loader = Zeitwerk::Loader.for_gem
loader.setup

def log(msg)
  PhotoTimeliner.configuration.logger.info(msg)
end

require 'json'
require 'thwait'

Thread.abort_on_exception = true
Thread.ignore_deadlock = false

module PhotoTimeliner
  extend Configure
  class Main
    def initialize
      @queue = Queue.new # SizedQueue.new(1)
    end

    def call
      producer = get_producer

      consumers = []
      options.thread_number.times.each { |consumer_number| consumers << get_consumer(consumer_number) }

      # rubocop:disable Lint/RescueException
      # rubocop:disable Lint/SuppressedException
      begin
        ThreadsWait.all_waits(*([producer] + consumers)) do |thread|
          log("Thread #{thread} has terminated.")
        end
      rescue Exception # queue.pop: No live threads left. Deadlock? (fatal)
      end
      # rubocop:enable Lint/RescueException
      # rubocop:enable Lint/SuppressedException
    end

    private

    def collection
      Dir.glob("#{options.source_directory}/**/*.{jpg,jpeg}")
    end

    def options
      PhotoTimeliner.configuration.options
    end

    def get_producer
      Thread.new do
        collection.each do |image_path|
          log("Reading... [#{File.basename(image_path).downcase}]")
          queue << { image_path: image_path }.to_json
        end
      end
    end

    def get_consumer(consumer_number)
      Thread.new do
        while (info = queue.pop)
          info = JSON.parse(info).transform_keys(&:to_sym)
          log("[#{consumer_number}] consumed #{info[:image_path]}")
          ImageHandler.new(**info).copy
        end
      end
    end

    attr_reader :queue
  end

  class Error < StandardError; end
end
