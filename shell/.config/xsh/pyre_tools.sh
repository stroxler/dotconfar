alias with-proxy="https_proxy=http://fwdproxy:8080 http_proxy=http://fwdproxy:8080"

rg-pyre () {
  rg -g '!_build' -g '!node_modules' "$@"
}
