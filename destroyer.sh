#!/bin/bash


envs=($(terraform workspace list |grep -v '\*'))
another=$(terraform workspace show)
envs+=($another)

for i in "${envs[@]}"
do
  terraform workspace select $i

  x=$(terraform show | grep -i create_date | head -1 | tr ' ' '\n' | tail -1 | tr '\"' ' ') 
  echo $x 

  future_time=$(date -d "$x + 15 minutes ")
  echo $future_time

  current_time=$(date )
  echo $current_time

  if [ "$current_time" \> "$future_time" ] && [ "$i" != "PROD" ]; then
    output=$(terraform plan)
    if echo "$output" | grep -q "No changes"; then
      terraform destroy -auto-approve -no-color
    fi
  fi

done