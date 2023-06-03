FROM python:3.11-alpine

ARG PLANTUML_VERSION=1.2023.8
ARG PLANTUML_CHECKSUM=abcd888cf8f2b1f231a789c47e485b94a0f50ef9

ARG TECHDOCS_CLI_VERSION=1.4.2
ARG MKDOCS_TECHDOCS_CORE_VERSION=1.2.1

SHELL ["/bin/ash", "-o", "pipefail", "-c"]

RUN apk update && apk --no-cache add gcc musl-dev openjdk17-jdk curl graphviz ttf-dejavu fontconfig nodejs npm && \
    curl -o plantuml.jar -L "https://github.com/plantuml/plantuml/releases/download/v${PLANTUML_VERSION}/plantuml-${PLANTUML_VERSION}.jar" && \
    echo "${PLANTUML_CHECKSUM}  plantuml.jar" | sha1sum -c - && \
    mv plantuml.jar /opt/plantuml.jar && \
    echo $'#!/bin/sh\n\njava -jar '/opt/plantuml.jar' ${@}' >> /usr/local/bin/plantuml && \
    chmod 755 /usr/local/bin/plantuml && \
    pip install --no-cache-dir "mkdocs-techdocs-core==${MKDOCS_TECHDOCS_CORE_VERSION}" && \
    npm install -g "@techdocs/cli@${TECHDOCS_CLI_VERSION}"

ENTRYPOINT [ "/bin/sh" ]
CMD [ "techdocs-cli" ]
