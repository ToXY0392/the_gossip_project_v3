class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  helper_method :current_user

  def current_user
    if session[:user_id].present?
      @current_user ||= User.find_by(id: session[:user_id])
    elsif (payload = cookies.signed[:remember_token]).is_a?(Array) && payload.size == 2
      user_id, token = payload
      user = User.find_by(id: user_id)
      if user&.remember_token_valid?(token)
        session[:user_id] = user.id
        @current_user = user
      end
    end
    @current_user
  end

  def remember_user(user)
    token = user.remember
    cookies.signed[:remember_token] = {
      value: [user.id, token],
      expires: 2.weeks.from_now
    }
  end

  def forget_user(user)
    user.forget
    cookies.delete(:remember_token)
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

  def require_login
    return if current_user

    redirect_to login_path, alert: "Tu dois être connecté pour accéder à cette page."
  end

  def record_not_found
    render file: Rails.public_path.join("404.html"), layout: false, status: :not_found
  end
end
