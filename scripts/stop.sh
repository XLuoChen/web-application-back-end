#!/bin/sh
# set -x

function get_pid_by_listened_port() {
  [[ $# -lt 1  ]] && { echo 'param error: must have one param(port)'; return -1;  }
  [[ $# -gt 1  ]] && { echo 'param error: only support one param(port)'; return -1;  }

  pattern_str="*:$1\\b"
  pid=$(ss -n -t -l -p | grep "$pattern_str" | column -t | awk -F ',' '{print $(NF-1)}')

  # 当版本号为 "ss utility, iproute2-ss161009" 时, ss 命令输出格式为:
  #               LISTEN  0  5  *:8000  *:*  users:(("python2.7",pid=7130,fd=3))
  # 此时需要进一步处理, 只获取进程 PID 值.

  [[ $pid =~ "pid" ]] && pid=$(echo $pid | awk -F '=' '{print $NF}')
  echo $pid
}

function kill_pid_by_listened_port() {
  pid=$(get_pid_by_listened_port $1)
  [[ -n "$pid" ]] && { echo "find pid: $pid, kill it..."; kill $pid; }
  [[ -n "$pid" ]] || { echo "not found listened port: $1"; }
}

kill_pid_by_listened_port 8080