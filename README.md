# backstage-techdocs-image

Single container which contains `mkdocs` and `techdocs-cli`.

Pull the [image](https://github.com/terrycain/backstage-techdocs-image/pkgs/container/backstage-techdocs-image) with:
```shell
docker pull ghcr.io/terrycain/backstage-techdocs-image
```

## Github Actions Example

Below is an example of publishing docs to AWS S3.

```yaml
name: Publish TechDocs Site

on:
  push:
    branches:
      - 'main'
    paths:
      - "docs/**"
      - "mkdocs.yml"

jobs:
  publish-techdocs-site:
    runs-on: ubuntu-latest
    container: ghcr.io/terrycain/backstage-techdocs-image:latest

    env:
      TECHDOCS_S3_BUCKET_NAME: ${{ secrets.TECHDOCS_S3_BUCKET_NAME }}
      AWS_ACCESS_KEY_ID: ${{ secrets.TECHDOCS_AWS_ACCESS_KEY_ID }}
      AWS_SECRET_ACCESS_KEY: ${{ secrets.TECHDOCS_AWS_SECRET_ACCESS_KEY }}
      AWS_REGION: ${{ secrets.TECHDOCS_AWS_REGION }}
      ENTITY_NAMESPACE: 'default'
      ENTITY_KIND: 'Component'
      ENTITY_NAME: 'someservice'

    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Generate docs site
        run: techdocs-cli generate --no-docker --verbose

      - name: Publish docs site
        run: techdocs-cli publish --publisher-type awsS3 --storage-name $TECHDOCS_S3_BUCKET_NAME --entity $ENTITY_NAMESPACE/$ENTITY_KIND/$ENTITY_NAME
```
