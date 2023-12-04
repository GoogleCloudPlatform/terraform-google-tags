# terraform-google-tags

## Description
### Tagline
This is an auto-generated module.

### Detailed
This module was generated from [terraform-google-module-template](https://github.com/terraform-google-modules/terraform-google-module-template/), which by default generates a module that simply creates a GCS bucket. As the module develops, this README should be updated.

The resources/services/activations/deletions that this module will create/trigger are:

- Create a GCS bucket with the provided name

### PreDeploy
To deploy this blueprint you must have an active billing account and billing permissions.

## Architecture
![alt text for diagram](https://www.link-to-architecture-diagram.com)
1. Architecture description step no. 1
2. Architecture description step no. 2
3. Architecture description step no. N

## Documentation
- [Hosting a Static Website](https://cloud.google.com/storage/docs/hosting-static-website)

## Deployment Duration
Configuration: X mins
Deployment: Y mins

## Cost
[Blueprint cost details](https://cloud.google.com/products/calculator?id=02fb0c45-cc29-4567-8cc6-f72ac9024add)

## Usage

Basic usage of this module is as follows:

```hcl
module "tags" {
  source  = "terraform-google-modules/tags/google"
  version = "~> 0.1"

  project_id  = "<PROJECT ID>"
  bucket_name = "gcs-test-bucket"
}
```

Functional examples are included in the
[examples](./examples/) directory.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| key | Key for Tags | `string` | n/a | yes |
| key\_description | Description for the Key | `string` | `""` | no |
| key\_iam | Additive IAM members for the Key | `map(list(string))` | `{}` | no |
| key\_purpose | Purpose specification for the Key | `string` | `""` | no |
| key\_purpose\_data | Purpose Data specification for the key | `map(string)` | `{}` | no |
| org\_id | Organization ID | `string` | `""` | no |
| project\_number | Project Number | `string` | `""` | no |
| tag\_for | Tags Created for organization or project | `string` | `"organization"` | no |
| values | Value specifications | <pre>list(object({<br>    value       = string<br>    description = string<br>    tag_binding = map(list(string))<br>    iam         = map(list(string))<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| key\_id | Key ID |
| key\_name | Key Name |
| key\_namespaced\_name | Key Namespaced Name |
| tag\_binding\_ids | List of Tag Binding Ids |
| tag\_binding\_location\_ids | List of Tag Binding Location Ids |
| tag\_binding\_location\_names | List of Tag Binding Location Names |
| tag\_binding\_names | List of Tag Binding Names |
| value\_ids | List of Value Ids |
| value\_names | List of Value Names |
| value\_namespaced\_names | List of Value Namespaced Names |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

- [Terraform][terraform] v0.13
- [Terraform Provider for GCP][terraform-provider-gcp] plugin v3.0

### Service Account

A service account with the following roles must be used to provision
the resources of this module:

- Storage Admin: `roles/storage.admin`

The [Project Factory module][project-factory-module] and the
[IAM module][iam-module] may be used in combination to provision a
service account with the necessary roles applied.

### APIs

A project with the following APIs enabled must be used to host the
resources of this module:

- Google Cloud Storage JSON API: `storage-api.googleapis.com`

The [Project Factory module][project-factory-module] can be used to
provision a project with the necessary APIs enabled.

## Contributing

Refer to the [contribution guidelines](./CONTRIBUTING.md) for
information on contributing to this module.

[iam-module]: https://registry.terraform.io/modules/terraform-google-modules/iam/google
[project-factory-module]: https://registry.terraform.io/modules/terraform-google-modules/project-factory/google
[terraform-provider-gcp]: https://www.terraform.io/docs/providers/google/index.html
[terraform]: https://www.terraform.io/downloads.html

## Security Disclosures

Please see our [security disclosure process](./SECURITY.md).
