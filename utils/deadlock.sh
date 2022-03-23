#!/bin/sh

# log base deadlock checker
declare -A map;
exitfn () {
  trap - SIGINT              # Restore signal handling for SIGINT
  for key in "${!map[@]}"; do
	if [ ${map[$key]} != 0 ]; then
	  echo "DEADLOCK: $key"
	fi
  done
  exit                     #   then exit script.
}

trap "exitfn" INT            # Set up SIGINT trap to call function.

while read CALL; do
  echo "$CALL"
  # if is >>>
  if [[ "$CALL" == *">>>"* ]]; then
	let map["$CALL"]++
  elif [[ "$CALL" == *"<<<"* ]]; then
	CALL=${CALL/<<</>>>}
	let map["$CALL"]--
  fi
done

for key in "${!map[@]}"; do
  if [ ${map[$key]} != 0 ]; then
	echo "DEADLOCK: $key"
  fi
done

trap - SIGINT                  # Restore signal handling to previous before exit.
