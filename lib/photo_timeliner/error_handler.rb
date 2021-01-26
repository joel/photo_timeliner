# frozen_string_literal: true

module PhotoTimeliner
  module ErrorHandler
    def safe_exe(msg: nil)
      r = nil
      begin
        r = yield
      rescue StandardError => e
        log("[#{msg}] Execution Error [#{file_name}]")
        log(e.message)
      end
      r
    end
  end
end
