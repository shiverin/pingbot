#!/usr/bin/env bash
set -u

name="${1:?usage: ping_url.sh <name> <url> <log-file>}"
url="${2:?usage: ping_url.sh <name> <url> <log-file>}"
log_file="${3:?usage: ping_url.sh <name> <url> <log-file>}"

connect_timeout="${CONNECT_TIMEOUT:-15}"
max_time="${MAX_TIME:-180}"
retry_count="${RETRY_COUNT:-1}"
retry_delay="${RETRY_DELAY:-5}"
timestamp="$(date -u '+%Y-%m-%d %H:%M:%S UTC')"
body_file="$(mktemp)"

set +e
curl_result="$(
  curl \
    --silent \
    --show-error \
    --location \
    --output "$body_file" \
    --write-out "status=%{http_code} time=%{time_total}s final_url=%{url_effective} size=%{size_download}B" \
    --connect-timeout "$connect_timeout" \
    --max-time "$max_time" \
    --retry "$retry_count" \
    --retry-delay "$retry_delay" \
    --retry-all-errors \
    "$url" 2>&1
)"
curl_exit=$?
set -e

rm -f "$body_file"
curl_result="$(printf '%s' "$curl_result" | tr '\n' ' ' | sed 's/[[:space:]][[:space:]]*/ /g')"

echo "$timestamp - $name exit=$curl_exit $curl_result" | tee -a "$log_file"

status="$(printf '%s\n' "$curl_result" | sed -n 's/.*status=\([0-9][0-9][0-9]\).*/\1/p')"

if [ "$curl_exit" -ne 0 ] || [ -z "$status" ] || [ "$status" = "000" ] || [ "$status" -ge 500 ]; then
  exit 1
fi
