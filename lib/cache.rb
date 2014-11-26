if ENV["REDISCLOUD_URL"]
  uri = URI.parse(ENV["REDISCLOUD_URL"])
  $redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
else
  $redis = Redis.new
end

class Redis
  def cache(key, expire = nil, recalculate = false)
    if (value = get(key)).nil? || recalculate
      value = yield(self)
      set(key, Marshal.dump(value))
      expire(key, expire) if expire
      value
    else
      Marshal.load(value)
    end
  end
end