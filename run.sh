#!/bin/sh

cd /app/input/contracts_combine/
FILES=*.sol

for filepath in $FILES
do
  # /app/input/MyContract.sol --> MyContract.sol
  filename=$(basename "$filepath")

  # ignore Migrations.sol file
  if [ $filename = "Migrations.sol" ]; then
    continue
  fi

  contractname=`node /app/get-last-contract-name $filepath`

  echo "executing $contractname"

  # graph
  surya graph $filepath | dot -Tpng | base64 > /app/output/graph/$filename
  node /app/png-to-dataurl.js /app/output/graph/$filename

  # describe
  surya describe $filepath > /app/output/describe/$filename
  node /app/remove-describe-except-own-contract.js /app/output/describe/$filename $contractname

  # parse
  surya parse $filepath > /app/output/parse/$filename
  node /app/parse-remove-other-contracts.js /app/output/parse/$filename $contractname

  # ftrace
  functionnames=`node /app/extract-function-names-of-contract.js $filename`

  for functionname in $functionnames
  do
    surya ftrace "$contractname::$functionname" all $filepath >> /app/output/ftrace/$filename
  done
  echo "done executing $contractname"
done
