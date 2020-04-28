#!/bin/sh

set -x

source .envrc

read -d '' REQUEST_BODY << EOF
{
    "filter": {
        "field": "metric.label.cluster_id",
        "op": "EQ",
        "value": "$CLUSTER_NAME"
    },
    "group_by": [
        "metric.label.topic"
    ],
    "limit": 25,
    "metric": "io.confluent.kafka.server/sent_bytes/delta"
}
EOF

echo $REQUEST_BODY |curl -X POST https://api.telemetry.confluent.cloud/v1/metrics/cloud/attributes --user "$API_KEY:$API_SECRET" -H 'Content-Type: application/json' -d @- | jq '.'