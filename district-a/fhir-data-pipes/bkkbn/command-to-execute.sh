PATH_TO_THE_UBER_JAR=/d/SourceCodes/google/fhir-data-pipes/pipelines/batch/target/batch-bundled.jar && \
java -jar ${PATH_TO_THE_UBER_JAR} \
    --fhirServerUrl=http://fhir-server-bkkbn:8092/fhir \
    --resourceList=Patient,Practitioner \
    --fhirSinkPath=http://fhir-server-central:8098/fhir
