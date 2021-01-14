# frozen_string_literal: true

require 'shellwords'

module PhotoTimeliner
  class ExifVirtual
    def initialize(image_path)
      @image_path = image_path
    end

    def call
      relative_path = image_path.gsub(options.source_directory, '')[1..] # remove first /

      # For some reasons Dir.chdir doesn't get the excpected result
      # Dir.chdir(options.source_directory) do # conflicting chdir during another chdir block
      # end

      # rubocop:disable Style/CommandLiteral
      # rubocop:disable Layout/LineLength
      exif_info = %x[
        cd #{escape(options.source_directory)} &&
        docker run --rm -v "$(pwd):/work" -w /work ruby:2.7.2 sh -c 'gem install exif > /dev/null && ruby -r exif -e "puts Exif::Data.new(IO.read(%{#{relative_path}})).date_time"'
      ]
      # rubocop:enable Style/CommandLiteral
      # rubocop:enable Layout/LineLength

      exif_info.chomp! # remove carriage return

      DateTime.strptime(exif_info, '%Y:%m:%d %H:%M:%S')
    end

    private

    attr_reader :image_path

    def options
      PhotoTimeliner.configuration.options
    end

    def escape(expr)
      Shellwords.escape(expr)
    end
  end
end
