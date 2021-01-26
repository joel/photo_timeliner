# frozen_string_literal: true

require 'shellwords'
require 'tty-command'

module PhotoTimeliner
  class ExifSystem
    def initialize(media_path)
      @media_path = media_path
    end

    def call
      cmd = TTY::Command.new(printer: printer_mode)
      result = cmd.run(
        "exiftool -s -s -s -d '%Y%m%d%H%M' -datetimeoriginal #{escape(media_path)}"
      )

      DateTime.strptime(result.out, '%Y%m%d%H%M')
    end

    private

    def printer_mode
      return :null unless options.verbose

      :pretty
    end

    def options
      PhotoTimeliner.configuration.options
    end

    def escape(expr)
      Shellwords.escape(expr)
    end

    attr_reader :media_path
  end
end
