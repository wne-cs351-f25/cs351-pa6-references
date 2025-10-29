#!/usr/bin/env bats

load '../../../../bin/relocate.bash'

@test "REF let" {
  relocate
  plccmk -c grammar > /dev/null
  RESULT="$(rep -n < ./tests/let/REF.input)"

  expected_output=$(< "./tests/let/REF.expected")
  [[ "$RESULT" == "$expected_output" ]]

}


