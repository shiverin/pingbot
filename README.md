# pingbot

GitHub Actions keepalive pinger for these Render apps:

- `https://messenger-ybyw.onrender.com/`
- `https://pdfiledit.onrender.com/`
- `https://o-alpha.onrender.com/`

The workflow pings often to keep the apps warm, but commits durable log entries about every 2 hours. Log entries include the final HTTP status, response time, final URL, and downloaded size.

GitHub scheduled workflows are best effort, so runs may be delayed or skipped during busy periods. The workflow can also be started manually from the Actions tab.
