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
      # "FileModifyDate"
      # "FileAccessDate"
      # "FileInodeChangeDate"
      # "DateTimeOriginal"
      # "CreateDate"
      # "DateCreated"
      # "ProfileDateTime"

      # result = cmd.run(
      #   "exiftool -s -s -s -d '%Y%m%d%H%M' -CreateDate #{escape(media_path)}"
      # )

      result = cmd.run(
        "exiftool -time:all -s #{escape(media_path)}"
      )

      hash_result.map do |entry|
        date_name, original_date_string = [ entry[:date_name], entry[:original_date_string] ]
        date_obj = parse_date(name: date_name, date_string: original_date_string)

        unless date_obj
          log("PARSING ERROR: [#{date_name}] => [#{original_date_string}]")
          next
        end

        date_string_short = date_obj.strftime('%Y%m%d%H%M')

        {
          name: date_name,
          date_string: date_string_short,
          date: date_obj
        }
      end.compact.min { |x, y| x[:date] <=> y[:date] }[:date]
    end

    private

    def hash_result(output)
      output.split("\n").map do |entry|
        date_name, original_date_string = entry.split(' : ').map(&:strip)
        {
          date_name: date_name,
          original_date_string: original_date_string
        }
      end
    end

    def parse_date(name:, date_string:, date: nil, formats: ['%Y:%m:%d %H:%M:%S%Z', '%Y:%m:%d %H:%M:%S'])
      return date if date || formats.empty?

      current_format = formats.shift

      date = nil
      begin
        date = DateTime.strptime(date_string, current_format)
      rescue Date::Error
        log("PARSING ERROR: [#{name}] => [#{date_string}]")
      end

      parse_date(name: name, date: date, date_string: date_string, formats: formats)
    end

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
