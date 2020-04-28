# Confluent Metrics API - Curl examples

Bashed based example for Confluent Metric API.

Please review full documentation of [Metrics API](https://docs.confluent.io/current/cloud/metrics-api.html) before going further.

## Prerequisites

* Bash based terminal
* curl
* [jq](https://stedolan.github.io/jq/)

## Generate credentials

```
ccloud login
ccloud kafka cluster use lkc-XXXXX
ccloud api-key create --resource cloud
```

## Prepare a credential file

Open `.envrc` and fill you credential informations

```
export API_KEY=YOUR-API-KEY
export API_SECRET=YOUR-API-SECRET
export CLUSTER_NAME=YOUR-CLUSTER
```

## Run the queries

### Descriptors

```
$ ./descriptors.sh
```

### Available Metrics

```
$ ./available-topics.sh
```

### Bytes written to all topics

Update the time interval from json attribute `intervals` from `bytes-written.sh` to the 6H window of your choice.

```
$ ./bytes-written.sh
```