#!/usr/bin/env bats

load '../../../../bin/relocate.bash'

@test "SET let" {
  relocate
  plccmk -c grammar > /dev/null
  RESULT="$(rep -n < ./tests/let/SET.input)"

  expected_output=$(< "./tests/let/SET.expected")
  [[ "$RESULT" == "$expected_output" ]]

}
