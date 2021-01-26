# frozen_string_literal: true

require 'shellwords'
require 'fileutils'
require 'exif'
require 'date'
require 'json'

module PhotoTimeliner
  class ImageHandler
    include ErrorHandler

    def initialize(image_path:)
      @image_path = image_path
    end

    def copy
      if File.exist?(target_file_path)
        log('SKIPPED! File already exists.')
        return
      end

      FileUtils.mkdir_p(File.dirname(target_file_path))

      copy_cmd = 'cp -p -f'
      copy_cmd += ' -v' if options.verbose

      system(
        "#{copy_cmd} #{escape(image_path)} #{escape(target_file_path)}"
      )

      system(
        "touch -a -m -t #{date_time.strftime('%Y%m%d%H%M')} #{escape(target_file_path)}"
      )
    end

    def file_name
      File.basename(image_path)
    end

    private

    def escape(expr)
      Shellwords.escape(expr)
    end

    def exif_date_time
      safe_exe(msg: 'EXIF') do
        ExifStrategy.new(image_path).call
      end
    end

    def file_date_time
      safe_exe(msg: 'CTIME') do
        File.ctime(image_path)
      end
    end

    def date_time
      @date_time ||= begin
        timestamp = exif_date_time
        timestamp ||= file_date_time
        timestamp
      end
    end

    def sub_target_directory
      return 'unknown' unless date_time

      year  = date_time.strftime('%Y')
      month = date_time.strftime('%m')

      "#{year}/#{month}"
    end

    def name_prefix
      return 'unknown' unless date_time

      date_time.strftime('%Y%m%d_%H%M%S')
    end

    def target_file_path
      @target_file_path ||= begin
        file_extention = File.extname(image_path)
        original_file_name = File.basename(image_path, '.*')

        "#{options.target_directory}/#{sub_target_directory}/" \
          "#{name_prefix}-#{original_file_name}#{file_extention.downcase}"
      end
    end

    def options
      PhotoTimeliner.configuration.options
    end

    attr_reader :image_path
  end
end
