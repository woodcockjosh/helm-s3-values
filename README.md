# Helm s3 values

This program extends the entire functionality of helm intercepting any `--values` paths that include `s3://` schema and download them to `/tmp` directory before completing the command.

## Installation

### Verify dependencies
```shell
which aws
which openssl
```

### Install plugin
```shell
helm plugin install https://github.com/woodcockjosh/s3-values.git
```

## Usage

#### Install
```shell
helm s3-values install world ./examples/charts/hello \
--values s3://helm-s3-values-example/values.yaml
```

#### Upgrade
```shell
helm s3-values upgrade world ./examples/charts/hello \
--values s3://helm-s3-values-example/values.yaml
```

#### Other:
```
helm s3-values somecommand --values s3://helm-s3-values-example/values.yaml
```