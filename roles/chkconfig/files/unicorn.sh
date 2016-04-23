#!/bin/sh
#
# unicorn       Startup script for unicorn (a rails app)
#
# chkconfig: - 85 15
# description: unicorn a rails app

. /etc/rc.d/init.d/functions

PROG_NAME=unicorn
USER=samurai
APP_ROOT=/usr/local/rails/samurai_mail_system/current
RAILS_ENV=production
PID_FILE=$APP_ROOT/tmp/pids/unicorn.pid
CONFIG_FILE=$APP_ROOT/config/unicorn.rb
CMD="cd ${APP_ROOT} && BUNDLE_GEMFILE=${APP_ROOT}/Gemfile bundle exec unicorn_rails"
ARGS="-c $CONFIG_FILE -D -E $RAILS_ENV"
export PATH=/usr/local/bin:$HOME/.rvm/bin:/usr/local/rvm/gems/ruby-2.2.3@rails4/bin:/usr/local/rvm/gems/ruby-2.2.3@global/bin:/usr/local/rvm/rubies/ruby-2.2.3/bin:$PATH
export GEM_HOME=/usr/local/rvm/gems/ruby-2.2.3@rails4
export GEM_PATH=/usr/local/rvm/gems/ruby-2.2.3@rails4:/usr/local/rvm/gems/ruby-2.2.3@global
export SECRET_KEY_BASE=`cat /home/samurai/.taskapp_secret_key_base`

cd $APP_ROOT || exit 1
case $1 in
  start)
    su -c "bundle exec unicorn -E $RAILS_ENV -c $CONFIG_FILE -D" $USER
    ;;
  stop)
    killproc -p $PID_FILE $PROG_NAME -QUIT
    ;;
  restart)
    killproc -p $PID_FILE $PROG_NAME -USR2
    ;;
  *)
  echo >&2 "Usage: $0 <start|stop|restart>"
  exit 1
  ;;
esac