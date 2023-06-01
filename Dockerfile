FROM python:3.11-alpine

RUN apk update && apk --no-cache add gcc musl-dev openjdk17-jdk curl graphviz ttf-dejavu fontconfig nodejs npm && \
    curl -o plantuml.jar -L https://github.com/plantuml/plantuml/releases/download/v1.2023.8/plantuml-1.2023.8.jar && \
    echo "abcd888cf8f2b1f231a789c47e485b94a0f50ef9  plantuml.jar" | sha1sum -c - && \
    mv plantuml.jar /opt/plantuml.jar && \
    echo $'#!/bin/sh\n\njava -jar '/opt/plantuml.jar' ${@}' >> /usr/local/bin/plantuml && \
    chmod 755 /usr/local/bin/plantuml && \
    pip install mkdocs-techdocs-core==1.2.1 && \
    npm install -g @techdocs/cli

ENTRYPOINT [ "/bin/sh" ]
CMD [ "techdocs-cli" ]
