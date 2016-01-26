require 'redis-browser'
require 'sinatra'
require 'cf-app-utils'

class RedisUri
  def initialize(credentials_hash = CF::App::Credentials.find_by_service_label('p-redis'))
    @credentials_hash = credentials_hash
  end

  def connection_string(db = 0)
    creds = @credentials_hash
    "redis://:#{creds['password']}@#{creds['host']}:#{creds['port']}/#{db}"
  end
end

DBS = (0..10).to_a

RedisBrowser.configure({
    'connections' => Hash[DBS.collect { |i| ["#{i}", RedisUri.new.connection_string(i)] }].merge({
      'default' => RedisUri.new.connection_string(1)
    })
  })

RedisBrowser::Web.class_eval do
  use Rack::Auth::Basic, 'Protected Area' do |username, password|
    username == ENV['REDIS_BROWSER_USERNAME'] && password == ENV['REDIS_BROWSER_PASSWORD']
  end
end

run RedisBrowser::Web
