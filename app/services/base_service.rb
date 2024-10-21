# frozen_string_literal: true

class BaseService
  Response = Struct.new(:success?, :payload, :error) do
    def failure?
      !success?
    end
  end

  def self.call(**args)
    new.call(**args)
  rescue StandardError => e
    new.failure(e)
  end

  def success(payload = nil)
    Response.new(true, payload)
  end

  def failure(exception)
    Response.new(false, nil, exception)
  end
end
