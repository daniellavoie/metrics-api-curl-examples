#!/bin/sh

source .envrc

curl https://api.telemetry.confluent.cloud/v1/metrics/cloud/descriptors --user "$API_KEY:$API_SECRET" | jq '.'