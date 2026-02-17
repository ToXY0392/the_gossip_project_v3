class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  helper_method :current_user

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id].present?
  end

  # region agent log
  def agent_debug_log(hypothesis_id, message, data = {}, run_id: "pre-fix")
    payload = {
      id: "log_#{Time.now.to_f}",
      timestamp: (Time.now.to_f * 1000).to_i,
      location: caller_locations(1, 1).first.to_s,
      message: message,
      data: data,
      runId: run_id,
      hypothesisId: hypothesis_id
    }

    File.open(Rails.root.join(".cursor", "debug.log"), "a") do |f|
      f.puts(payload.to_json)
    end
  rescue StandardError => e
    Rails.logger.debug("agent_debug_log error: #{e.class}: #{e.message}")
  end
  # endregion agent log

  private

  def record_not_found
    render file: Rails.public_path.join("404.html"), layout: false, status: :not_found
  end
end
