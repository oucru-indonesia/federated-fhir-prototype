# Rumah Sakit Anggrek

```bash
curl 'http://localhost:8091/fhir/Patient' \
  -H 'Content-Type: application/fhir+json' \
  --data-raw $'{\n  "resourceType": "Patient",\n  "identifier": [\n    {\n      "system": "https://fhir.kemkes.go.id/id/nik",\n      "value": "1234567",\n      "use": "usual"\n    }\n  ],\n  "name": [\n    {\n      "text": "Levi Ackerman",\n      "family": "Ackerman",\n      "given": [\n        "Levi"\n      ]\n    }\n  ],\n  "birthDate": "1900-01-23",\n  "gender": "male"\n}' \
  --compressed
```

# Puskesmas Mawar

```bash
curl 'http://localhost:8092/Patient' \
  -H 'Content-Type: application/fhir+json' \
  --data-raw $'{\n  "resourceType": "Patient",\n  "identifier": [\n    {\n      "system": "https://fhir.kemkes.go.id/id/nik",\n      "value": "1234567",\n      "use": "usual"\n    }\n  ],\n  "name": [\n    {\n      "text": "Levi Ackerman",\n      "family": "Ackerman",\n      "given": [\n        "Levi"\n      ]\n    }\n  ],\n  "birthDate": "1900-01-23"\n}' \
  --compressed
```

# Posyandu Melati

```bash
curl 'http://localhost:8093/fhir/Patient' \
  -H 'Content-Type: application/fhir+json' \
  --data-raw $'{\n  "resourceType": "Patient",\n  "identifier": [\n    {\n      "system": "https://fhir.kemkes.go.id/id/nik",\n      "value": "1234567",\n      "use": "usual"\n    }\n  ],\n  "name": [\n    {\n      "text": "Levi Ackerman",\n      "family": "Ackerman",\n      "given": [\n        "Levi"\n      ]\n    }\n  ]\n}' \
  --compressed
```

# Run `pipeline/batch`

```bash
cd /mnt/d/SourceCodes/google/fhir-data-pipes

java -cp ./pipelines/batch/target/batch-bundled-0.1.0-SNAPSHOT.jar \
    com.google.fhir.analytics.FhirEtl \
    --fhirServerUrl=http://localhost:8091/fhir \
    --resourceList=Patient,Encounter,Observation \
    --fhirSinkPath=http://localhost:8098/fhir

java -cp ./pipelines/batch/target/batch-bundled-0.1.0-SNAPSHOT.jar \
    com.google.fhir.analytics.FhirEtl \
    --fhirServerUrl=http://localhost:8092/fhir \
    --resourceList=Patient,Encounter,Observation \
    --fhirSinkPath=http://localhost:8098/fhir

java -cp ./pipelines/batch/target/batch-bundled-0.1.0-SNAPSHOT.jar \
    com.google.fhir.analytics.FhirEtl \
    --fhirServerUrl=http://localhost:8093/fhir \
    --resourceList=Patient,Encounter,Observation \
    --fhirSinkPath=http://localhost:8098/fhir
```
