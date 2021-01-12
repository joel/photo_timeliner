#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/photo_timeliner'

require 'pry'

options = {
  source_directory: './fixtures/unsorted',
  target_directory: './fixtures/sorted'
}

PhotoTimeliner::Main.new(options).call
