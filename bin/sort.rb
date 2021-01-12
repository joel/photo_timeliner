#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/photo_timeliner'

require 'pry'

instance = PhotoTimeliner::Cli.new
instance.call
