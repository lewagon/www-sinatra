module Rack
  class BlockReferalSpam
    def initialize(app)
      @app = app
    end

    def call(env)
      if spam?(env)
        forbidden
      else
        @app.call(env)
      end
    end

    private

    def forbidden
      [403, {"Content-Type" => "text/plain"}, ["Go away!\n"]]
    end

    def spam?(env)
      referer = env['HTTP_REFERER'] || ''
      referer =~ /(semalt\.com)|(darodar\.com)|(iloveitaly\.com)|(makemoneyonline\.com)/
    end
  end
end
