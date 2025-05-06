# Notes

- Need to allow POST or other HTTP Methods first in the channels
- `ce9b08d6-e2c1-4827-8f3c-7fb3f7dfb8c4` is Custom Client Secret of "Rumah Sakit Anggrek"

# Rumah Sakit Anggrek

```bash
curl 'https://interoperability-layer.sid-indonesia.org/rumah-sakit-anggrek/fhir-server/Patient' \
  -H 'Authorization: Custom ce9b08d6-e2c1-4827-8f3c-7fb3f7dfb8c4' \
  -H 'Content-Type: application/fhir+json' \
  --data-raw $'{\n  "resourceType": "Patient",\n  "identifier": [\n    {\n      "system": "https://fhir.kemkes.go.id/id/nik",\n      "value": "1234567",\n      "use": "usual"\n    }\n  ],\n  "name": [\n    {\n      "text": "Levi Ackerman",\n      "family": "Ackerman",\n      "given": [\n        "Levi"\n      ]\n    }\n  ],\n  "birthDate": "1900-01-23",\n  "gender": "male"\n}' \
  --compressed
```

# Puskesmas Mawar

```bash
curl 'https://interoperability-layer.sid-indonesia.org/puskesmas-mawar/fhir-server/Patient' \
  -H 'Authorization: Custom ce9b08d6-e2c1-4827-8f3c-7fb3f7dfb8c4' \
  -H 'Content-Type: application/fhir+json' \
  --data-raw $'{\n  "resourceType": "Patient",\n  "identifier": [\n    {\n      "system": "https://fhir.kemkes.go.id/id/nik",\n      "value": "1234567",\n      "use": "usual"\n    }\n  ],\n  "name": [\n    {\n      "text": "Levi Ackerman",\n      "family": "Ackerman",\n      "given": [\n        "Levi"\n      ]\n    }\n  ],\n  "birthDate": "1900-01-23"\n}' \
  --compressed
```

# Posyandu Melati

```bash
curl 'https://interoperability-layer.sid-indonesia.org/posyandu-melati/fhir-server/Patient' \
  -H 'Authorization: Custom ce9b08d6-e2c1-4827-8f3c-7fb3f7dfb8c4' \
  -H 'Content-Type: application/fhir+json' \
  --data-raw $'{\n  "resourceType": "Patient",\n  "identifier": [\n    {\n      "system": "https://fhir.kemkes.go.id/id/nik",\n      "value": "1234567",\n      "use": "usual"\n    }\n  ],\n  "name": [\n    {\n      "text": "Levi Ackerman",\n      "family": "Ackerman",\n      "given": [\n        "Levi"\n      ]\n    }\n  ]\n}' \
  --compressed
```

# Test

```bash
curl 'https://interoperability-layer.sid-indonesia.org/fhir-server/Patient' \
  -H 'Authorization: Custom b0043789-a7e0-4c96-b9cc-41b6d01c716d' \
  -H 'Content-Type: application/fhir+json' \
  --data-raw $'{\n  "resourceType": "Patient",\n  "identifier": [\n    {\n      "system": "https://fhir.kemkes.go.id/id/nik",\n      "value": "123456789",\n      "use": "usual"\n    }\n  ],\n  "name": [\n    {\n      "text": "Test Patient",\n      "family": "Patient",\n      "given": [\n        "Test"\n      ]\n    }\n  ]\n}' \
  --compressed
```
