#!/bin/bash

# GET from logging in
cookie=""

function postCreateChannel {
  channelName=$1
  urlPath=$2
  sanitizedUrlPath=${urlPath//\//\\\\\/}
  routeHost=$3
  port=$4
  allowedRole=$5
  allowedMethods=$6

  jsonData="{ \"type\": \"http\", \"authType\": \"private\", \"status\": \"enabled\", \"routes\": [ { \"name\": \"$channelName\", \"secured\": false, \"host\": \"${routeHost}\", \"port\": \"${port}\", \"path\": \"\", \"pathTransform\": \"s/${sanitizedUrlPath}/fhir/g\", \"primary\": true, \"username\": \"\", \"password\": \"\", \"type\": \"http\", \"status\": \"enabled\", \"forwardAuthHeader\": false, \"kafkaClientId\": \"\", \"kafkaTopic\": \"\", \"waitPrimaryResponse\": false, \"statusCodesCheck\": \"\" } ], \"requestBody\": true, \"responseBody\": true, \"rewriteUrlsConfig\": [], \"rewriteUrls\": false, \"addAutoRewriteRules\": true, \"name\": \"$channelName\", \"urlPattern\": \"^/$urlPath/.*$\", \"whitelist\": [], \"allow\": ${allowedRole}, \"methods\": ${allowedMethods}, \"matchContentRegex\": null, \"matchContentXpath\": null, \"matchContentValue\": null, \"matchContentJson\": null, \"pollingSchedule\": null, \"tcpHost\": null, \"tcpPort\": null }"
  # jsonData="{ \"type\": \"http\", \"authType\": \"private\", \"status\": \"enabled\", \"routes\": [ { \"name\": \"$channelName\", \"secured\": false, \"host\": \"${routeHost}\", \"port\": \"${port}\", \"path\": \"\", \"pathTransform\": \"s/${sanitizedUrlPath}/fhir/g\", \"primary\": true, \"username\": \"\", \"password\": \"\", \"type\": \"http\", \"status\": \"enabled\", \"forwardAuthHeader\": false, \"kafkaClientId\": \"\", \"kafkaTopic\": \"\", \"waitPrimaryResponse\": false, \"statusCodesCheck\": \"\" } ], \"requestBody\": true, \"responseBody\": true, \"rewriteUrlsConfig\": [], \"rewriteUrls\": false, \"addAutoRewriteRules\": true, \"name\": \"$channelName\", \"urlPattern\": \"^/$urlPath/.*$\", \"whitelist\": [], \"allow\": [ \"${allowedRole}\" ], \"priority\": 1, \"methods\": [ \"GET\" ], \"matchContentRegex\": null, \"matchContentXpath\": null, \"matchContentValue\": null, \"matchContentJson\": null, \"pollingSchedule\": null, \"tcpHost\": null, \"tcpPort\": null }"

  curl 'https://localhost:8080/channels' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  -H "Cookie: $cookie" \
  --data-raw "$jsonData" \
  --compressed \
  --insecure
  echo ": $channelName"
}

function postCreateClient {
  clientID=$1
  name=$2
  roles=$3
  customTokenID=$4
  organization=$5
  softwareName=$6
  location=$7
  contactPerson=$8

  jsonData="{ \"roles\": ${roles}, \"clientID\": \"${clientID}\", \"name\": \"${name}\", \"organization\": \"${organization}\", \"softwareName\": \"${softwareName}\", \"location\": \"${location}\", \"contactPerson\": \"${contactPerson}\", \"customTokenID\": \"${customTokenID}\" }"

  curl 'https://localhost:8080/clients' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  -H "Cookie: $cookie" \
  --data-raw "$jsonData" \
  --compressed \
  --insecure
}

function loginThenGetCookie {
  response=$(curl 'https://localhost:8080/authenticate/local' \
    -H 'Content-Type: application/json;charset=UTF-8' \
    --data-raw '{"username":"root@openhim.org","password":"instant101"}' \
    --compressed \
    --insecure \
    -i) # Include headers in the response

  # Use grep and awk to extract all "Set-Cookie" values into an array
  cookies=($(echo "$response" | grep -i 'Set-Cookie' | awk -F' ' '{print $2}'))

  # Concatenate all extracted cookies into a single variable
  cookie=$(echo "${cookies[*]}")
}

loginThenGetCookie

postCreateChannel 'District A - Ministry of Health - FHIR Server' ministry-of-health/fhir-server fhir-server-ministry-of-health 8091 '[ "Interoperable Systems" ]' '[ "GET" ]'
postCreateChannel 'District A - BKKBN - FHIR Server' bkkbn/fhir-server fhir-server-bkkbn 8092 '[ "Interoperable Systems" ]' '[ "GET" ]'
postCreateChannel 'District A - Ministry of Village Development - FHIR Server' ministry-of-village-development/fhir-server fhir-server-ministry-of-village-development 8093 '[ "Interoperable Systems" ]' '[ "GET" ]'
postCreateChannel 'District A - FHIR Server Central (Read-only)' fhir-server fhir-server-central 8098 '[ "Interoperable Systems", "Smart Synchronizer" ]' '[ "GET" ]'
postCreateChannel 'District A - FHIR Server Central (All Access)' fhir-server fhir-server-central 8098 '[ "Smart Synchronizer" ]' '[ "GET", "POST", "DELETE", "PUT", "OPTIONS", "HEAD", "TRACE", "CONNECT", "PATCH" ]'

postCreateClient 'district-a-ministry-of-health' 'District A - Ministry of Health' '[ "Interoperable Systems" ]' 'district-a-ministry-of-health' 'Ministry of Health' 'FHIR Server' 'District A'
postCreateClient 'district-a-bkkbn' 'District A - BKKBN' '[ "Interoperable Systems" ]' 'district-a-bkkbn' 'BKKBN' 'FHIR Server' 'District A'
postCreateClient 'district-a-ministry-of-village-development' 'District A - Ministry of Village Development' '[ "Interoperable Systems" ]' 'district-a-ministry-of-village-development' 'Ministry of Village Development' 'FHIR Server' 'District A'
postCreateClient 'smart-synchronizer' 'Smart Synchronizer' '[ "Interoperable Systems", "Smart Synchronizer" ]' 'smart-synchronizer' 'District A' 'Smart Synchronizer' 'District A'
