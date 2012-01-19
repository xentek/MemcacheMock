require "memcache_mock/version"

class MemcacheMock
  def initialize( )
    @values = {}
  end

  def incr( key, value, ttl, default_value )
    if @values[key]
      append( key, value )
    else
      @values[key] = default_value
    end
  end

  def get( key )
    @values[key] ? @values[key].to_s : nil
  end

  def get_multi( keys )
    @values.select { |k, v| keys.include?( k ) }
  end

  def set( key, value, ttl, options = {} )
    @values[key] = value
  end

  def update( key, default, ttl = nil, options = nil )
    @values[key] = yield( @values[key] || default )
  end

  def append( key, value )
    if @values[key]
      @values[key] += value
    end
  end

  def flush
    @values.clear
  end
end