```bash
helm repo add crossplane-master \
    https://charts.crossplane.io/master

helm repo update

helm upgrade --install crossplane crossplane-master/crossplane \
    --namespace crossplane-system --create-namespace --wait \
    --devel

echo '
---
apiVersion: pkg.crossplane.io/v1
kind: Provider
metadata:
  name: provider-aws-s3
spec:
  package: xpkg.upbound.io/upbound/provider-aws-s3:v0.36.0
---
apiVersion: pkg.crossplane.io/v1
kind: Provider
metadata:
  name: provider-aws-dynamodb
spec:
  package: xpkg.upbound.io/upbound/provider-aws-dynamodb:v0.36.0
' | kubectl apply --filename -

echo '
apiVersion: pkg.crossplane.io/v1beta1
kind: Function
metadata:
  name: function-patch-and-transform
spec:
  package: xpkg.upbound.io/crossplane-contrib/function-patch-and-transform:v0.1.4
' | kubectl apply --filename -

echo '
apiVersion: apiextensions.crossplane.io/v1
kind: CompositeResourceDefinition
metadata:
  name: nosqls.database.example.com
spec:
  group: database.example.com
  names:
    kind: NoSQL
    plural: nosqls
  versions:
  - name: v1alpha1
    schema:
      openAPIV3Schema:
        type: object
        properties:
          spec:
            type: object
            properties:
              location:
                type: string
                oneOf:
                  - pattern: '^EU$'
                  - pattern: '^US$'
            required:
              - location
    served: true
    referenceable: true
  claimNames:
    kind: NoSQLClaim
    plural: nosqlclaim
' | kubectl apply --filename -

echo '
apiVersion: apiextensions.crossplane.io/v1
kind: Composition
metadata:
  name: dynamo-with-bucket
spec:
  compositeTypeRef:
    apiVersion: database.example.com/v1alpha1
    kind: NoSQL
  mode: Pipeline
  pipeline:
  - step: patch-and-transform
    functionRef:
      name: function-patch-and-transform
    input:
      apiVersion: pt.fn.crossplane.io/v1beta1
      kind: Resources
      resources:
      - name: s3Bucket
        base:
          apiVersion: s3.aws.upbound.io/v1beta1
          kind: Bucket
          metadata:
            name: crossplane-quickstart-bucket
          spec:
            forProvider:
              region: us-east-2
        patches:
        - type: FromCompositeFieldPath
          fromFieldPath: "location"
          toFieldPath: "spec.forProvider.region"
          transforms:
          - type: map
            map: 
              EU: "eu-north-1"
              US: "us-east-2"
      - name: dynamoDB
        base:
          apiVersion: dynamodb.aws.upbound.io/v1beta1
          kind: Table
          metadata:
            name: crossplane-quickstart-database
          spec:
            forProvider:
              region: "us-east-2"
              writeCapacity: 1
              readCapacity: 1
              attribute:
              - name: S3ID
                type: S
              hashKey: S3ID
        patches:
        - type: FromCompositeFieldPath
          fromFieldPath: "spec.location"
          toFieldPath: "spec.forProvider.region"
          transforms:
          - type: map
            map: 
              EU: "eu-north-1"
              US: "us-east-2"
' | kubectl apply --filename -

echo '
apiVersion: database.example.com/v1alpha1
kind: NoSQLClaim
metadata:
  name: my-nosql-database
spec: 
  location: "US"
' | kubectl apply --filename -

kubectl get nosqlclaim

kubectl get nosql

# TODO: https://github.com/negz/xrender
```