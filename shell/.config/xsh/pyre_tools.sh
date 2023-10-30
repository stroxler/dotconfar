rg-pyre () {
  rg -g '!_build' -g '!node_modules' "$@"
}
