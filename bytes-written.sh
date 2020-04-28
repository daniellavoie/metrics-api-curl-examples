#!/bin/sh

set -x

source .envrc

read -d '' REQUEST_BODY << EOF
{
  "aggregations": [
      {
          "agg": "SUM",
          "metric": "io.confluent.kafka.server/sent_bytes/delta"
      }
  ],
  "filter": {
      "filters": [
          {
              "field": "metric.label.cluster_id",
              "op": "EQ",
              "value": "$CLUSTER_NAME"
          }
      ],
      "op": "AND"
  },
  "granularity": "PT1M",
  "group_by": [
      "metric.label.topic"
  ],
  "intervals": [
      "2020-04-28T06:00:00-05:00/2020-04-28T10:00:00-05:00"
  ],
  "limit": 25
  }
}
EOF

echo $REQUEST_BODY |curl -X POST https://api.telemetry.confluent.cloud/v1/metrics/cloud/query --user "$API_KEY:$API_SECRET" -H 'Content-Type: application/json' -d @- | jq '.'