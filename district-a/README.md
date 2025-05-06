# District A

- Append the following to `/etc/hosts`:
  - ```
    127.0.0.1	interoperability-layer.district-a
    127.0.0.1	interoperability-layer.district-b
    127.0.0.1	interoperability-layer.nation-a
    127.0.0.1	fhir-server-central
    127.0.0.1	fhir-server-ministry-of-health
    127.0.0.1	fhir-server-bkkbn
    127.0.0.1	fhir-server-ministry-of-village-development
    ```

## Installation Steps

```bash
cd /path/to/it-team/local-development-resources/federated-fhir-servers-prototype/district-a && \
docker-compose up -d && \
./prepopulate-openhim-data.sh
```

## Interoperability Layer - OpenHIM Console

Accessible at http://interoperability-layer.district-a:9000

```bash
# Requests on behalf of "smart-syncronizer"
curl http://interoperability-layer.district-a:5001/ministry-of-health/fhir-server/Patient -H 'Authorization: Custom smart-synchronizer'
curl http://interoperability-layer.district-a:5001/ministry-of-village-development/fhir-server/Patient -H 'Authorization: Custom smart-synchronizer'
curl http://interoperability-layer.district-a:5001/bkkbn/fhir-server/Patient -H 'Authorization: Custom smart-synchronizer'
curl http://interoperability-layer.district-a:5001/fhir-server/Patient -H 'Authorization: Custom smart-synchronizer'

# Requests on behalf of "Ministry of Health"
curl http://interoperability-layer.district-a:5001/ministry-of-village-development/fhir-server/Patient -H 'Authorization: Custom district-a-ministry-of-health'
curl http://interoperability-layer.district-a:5001/bkkbn/fhir-server/Patient -H 'Authorization: Custom district-a-ministry-of-health'
curl http://interoperability-layer.district-a:5001/fhir-server/Patient -H 'Authorization: Custom district-a-ministry-of-health'

# Requests on behalf of "Ministry of Village Development"
curl http://interoperability-layer.district-a:5001/ministry-of-health/fhir-server/Patient -H 'Authorization: Custom district-a-ministry-of-village-development'
curl http://interoperability-layer.district-a:5001/bkkbn/fhir-server/Patient -H 'Authorization: Custom district-a-ministry-of-village-development'
curl http://interoperability-layer.district-a:5001/fhir-server/Patient -H 'Authorization: Custom district-a-ministry-of-village-development'

# Requests on behalf of "BKKBN"
curl http://interoperability-layer.district-a:5001/ministry-of-health/fhir-server/Patient -H 'Authorization: Custom district-a-bkkbn'
curl http://interoperability-layer.district-a:5001/ministry-of-village-development/fhir-server/Patient -H 'Authorization: Custom district-a-bkkbn'
curl http://interoperability-layer.district-a:5001/fhir-server/Patient -H 'Authorization: Custom district-a-bkkbn'
```

## Reinitialize DB Steps

```bash
cd /d/SourceCodes/SID/it-team/local-development-resources/federated-fhir-servers-prototype/district-a && \
docker-compose down database-interoperability-layer && \
docker volume rm district-a_database-interoperability-layer && \
docker-compose up -d
```

```bash
cd /d/SourceCodes/SID/it-team/local-development-resources/federated-fhir-servers-prototype/district-a && \
docker-compose down database-ministry-of-health database-bkkbn database-ministry-of-village-development database-central && \
docker volume rm district-a_database-ministry-of-health district-a_database-bkkbn district-a_database-ministry-of-village-development district-a_database-central && \
docker-compose up -d
```
