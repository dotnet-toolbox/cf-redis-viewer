# cf-redis-viewer
the monterail/redis-browser gem, wrapped with basic auth and plugged into VCAP_SERVICES, for peeking at your PCF redis DB

## Motivation & Assumptions
If you have a Redis DB on PCF, and you're not able to connect to the Redis db using `redis-cli`, you might benefit from having a redis web client handy for debugging your non-production instances. If that's you, you can use this! You'll need to push this repo as a new CF app in an app space where you're using redis, then bind the redis service to this app.

## Environment Variables:
This CF app uses `Rack::Auth::Basic`. Use the `REDIS_BROWSER_USERNAME` and `REDIS_BROWSER_PASSWORD` to control the basic auth username and password. This code is not meant to be deployed as-is in a production environment where data is valuable or sensitive.

## Deployment
```bash
% cf target -o <your-org> -s <your-app-space-where-you-are-using-redis>
% cf push <your-appname-here>
