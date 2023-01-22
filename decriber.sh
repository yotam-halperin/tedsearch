#!/bin/bash

counter=0

envs=($(terraform workspace list |grep -v '\*'))
another=$(terraform workspace show)
envs+=($another)

for i in "${envs[@]}"
do
  terraform workspace select $i
    output=$(terraform plan)
  if echo "$output" | grep -q "No changes"; then
    echo "$i is up and run"
    counter=$[$counter+1]
  else
    echo "$i down"
  fi
done

echo "$counter enviroments are up and run!"

