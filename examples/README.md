Examples: 

```shell
helm s3-values upgrade world ./examples/charts/hello \
--values s3://helm-s3-values-example/values.yaml
```

```shell
helm s3-values upgrade world ./examples/charts/message \
--values s3://helm-s3-values-example/first.values.yaml \
--values s3://helm-s3-values-example/last.values.yaml \
--values https://helm-s3-values-example.s3.us-east-2.amazonaws.com/message.values.yaml \
--values examples/data/exclaim.values.yaml
```