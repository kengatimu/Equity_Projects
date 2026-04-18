#!/bin/sh
# ============================================================================
# Tanuki Wrapper start/stop script for dr-platform-api
# Usage: ./drplatform.sh { start | stop | status | restart | install | remove }
# ============================================================================

WRAPPER_CMD="./wrapper"
WRAPPER_CONF="../tanuki/wrapper.conf"
PIDFILE="../run/drplatform.pid"

# Detect OS
UNAME=$(uname)

case "$1" in
  start)
    echo "Starting Equity Bank DR Platform..."
    $WRAPPER_CMD -c $WRAPPER_CONF &
    ;;
  stop)
    echo "Stopping Equity Bank DR Platform..."
    if [ -f "$PIDFILE" ]; then
      kill $(cat $PIDFILE)
      rm -f $PIDFILE
    else
      echo "PID file not found — is the service running?"
    fi
    ;;
  restart)
    $0 stop
    sleep 3
    $0 start
    ;;
  status)
    if [ -f "$PIDFILE" ] && kill -0 $(cat $PIDFILE) 2>/dev/null; then
      echo "DR Platform is running (PID: $(cat $PIDFILE))"
    else
      echo "DR Platform is NOT running"
    fi
    ;;
  install)
    # Linux: install as systemd service via wrapper
    $WRAPPER_CMD -i $WRAPPER_CONF
    ;;
  remove)
    $WRAPPER_CMD -r $WRAPPER_CONF
    ;;
  *)
    echo "Usage: $0 { start | stop | restart | status | install | remove }"
    exit 1
    ;;
esac

exit 0
