# frozen_string_literal: true

module PhotoTimeliner
  class ExifBasic
    def initialize(media_path)
      @media_path = media_path
    end

    def call
      exif_info = Exif::Data.new(IO.read(media_path))
      return unless exif_info
      return unless exif_info&.date_time

      DateTime.strptime(exif_info.date_time, '%Y:%m:%d %H:%M:%S')
    end

    private

    attr_reader :media_path
  end
end
