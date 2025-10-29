#!/usr/bin/env bats

load '../../../../bin/relocate.bash'

@test "NAME let-proc" {
  relocate
  plccmk -c grammar > /dev/null
  RESULT="$(rep -n < ./tests/let-proc/NAME.input)"

  expected_output=$(< "./tests/let-proc/NAME.expected")
  [[ "$RESULT" == "$expected_output" ]]

}
