#!/bin/sh

set -x

source .envrc

read -d '' REQUEST_BODY << EOF
{
  "aggregations": [
      {
          "agg": "SUM",
          "metric": "io.confluent.kafka.server/request_count"
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
  "group_by": [],
  "intervals": [
      "2020-06-16T06:00:00-05:00/2020-06-16T10:00:00-05:00"
  ],
  "limit": 25
  }
}
EOF

echo $REQUEST_BODY |curl -X POST https://api.telemetry.confluent.cloud/v1/metrics/cloud/query --user "$API_KEY:$API_SECRET" -H 'Content-Type: application/json' -d @- | jq '.'