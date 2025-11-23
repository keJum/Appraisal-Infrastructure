#!/bin/sh
echo ''

SCRIPT_ROOT_DIR=$(dirname "$0")
cd "$SCRIPT_ROOT_DIR" || exit

DATA_DIR="./data"


start() {
  projectName="$1"
  if ! projectCheck "$projectName"; then
    return
  fi

  projectPath="$DATA_DIR/$1"
  docker compose -f "$projectPath/docker-compose.yml" up -d
}

restart() {
  projectName="$1"
  stop $projectName
  start $projectName
}

stop() {
  projectName="$1"
  if ! projectCheck "$projectName"; then
    return
  fi

  projectPath="$DATA_DIR/$1"
  docker compose -f "$projectPath/docker-compose.yml" down -v
}

rebuild() {
  projectName="$1"
  if ! projectCheck "$projectName"; then
    return
  fi

  projectPath="$DATA_DIR/$1"
  docker compose -f "$projectPath/docker-compose.yml" build --pull --no-cache
  docker compose -f "$projectPath/docker-compose.yml" up -d
}

projectCheck() {
  projectName="$1"

  while read -r line; do
    if [ "$line" = "$projectName" ]; then
      break
    fi
  done <<EOF
$(ls -1 "$DATA_DIR")
EOF
  if [ "$line" != "$projectName" ]; then
    echo "there is no $projectName in data folder"
    return 1
  fi

  return 0
}


cmd="$1"
test $# -gt 0 && shift

case "$cmd" in
start) start "$@" ;;
restart) restart "$@" ;;
rebuild) rebuild "$@" ;;
stop) stop "$@" ;;
esac