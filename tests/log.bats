#!/usr/bin/env bats
load test_helper
fixtures log
unset_term

@test 'ludicrous.mk log callable produces sensible output with TERM set' {
  export TERM=xterm
  run make -f $FIXTURES_ROOT/Makefile test1
  __debug "${status}" "${output}" "${lines[@]}"

  [ "$status" -eq 0 ]
  [ "$(cat -vet <(echo $output))" == "^[[1m===> the test1 target ^[(B^[[m$" ]
}

@test 'ludicrous.mk _log callable produces sensible output with TERM set' {
  export TERM=xterm
  run make -f $FIXTURES_ROOT/Makefile test2
  __debug "${status}" "${output}" "${lines[@]}"

  [ "$status" -eq 0 ]
  [ "${lines[0]}" == "/usr/bin/tput bold; echo \"===> the test2 target\"; /usr/bin/tput sgr0" ]
  [ "$(cat -vet <(echo ${lines[1]}))" == "^[[1m===> the test2 target$" ]
  [ "$(cat -vet <(echo ${lines[2]}))" == "^[(B^[[m$" ]
}

@test 'ludicrous.mk log callable produces sensible output without TERM' {
  run make -f $FIXTURES_ROOT/Makefile test1
  __debug "${status}" "${output}" "${lines[@]}"

  [ "$status" -eq 0 ]
  [ "$(cat -vet <(echo ${lines[0]}))" == "===> the test1 target$" ]
}

@test 'ludicrous.mk _log callable produces sensible output without TERM' {
  run make -f $FIXTURES_ROOT/Makefile test2
  __debug "${status}" "${output}" "${lines[@]}"

  [ "$status" -eq 0 ]
  [ "${lines[0]}" == "echo \"===> the test2 target\"" ]
  [ "$(cat -vet <(echo ${lines[1]}))" == "===> the test2 target$" ]
  [ "${lines[2]}" == "" ]
}
