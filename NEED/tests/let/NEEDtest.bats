#!/usr/bin/env bats

load '../../../../bin/relocate.bash'

@test "NEED let" {
  relocate
  plccmk -c grammar > /dev/null
  RESULT="$(rep -n < ./tests/let/NEED.input)"

  expected_output=$(< "./tests/let/NEED.expected")
  [[ "$RESULT" == "$expected_output" ]]

}

