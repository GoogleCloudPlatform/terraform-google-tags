# terraform-google-tags

## Description
This Terraform module makes it easier to create [tags](https://cloud.google.com/resource-manager/docs/tags/tags-overview) and bind them to [different resources/services](https://cloud.google.com/resource-manager/docs/tags/tags-supported-services) for your Google Cloud environment.


## Usage

Basic usage of this module is as follows:

```hcl
module "tags" {
  source  = "GoogleCloudPlatform/tags/google"
  version = "0.1.0"

  tag_for         = "project"
  project_number  = "9999999999999"
  key             = "key1"
  key_description = "first key"
  value_specs = [{
    value       = "value1"
    description = "first value"
    tag_binding = { "global" : ["//cloudresourcemanager.googleapis.com/projects/99999999999"],
                    "us-central1" : ["//run.googleapis.com/projects/9999999999999/locations/us-central1/services/hello1"] }
    }, {
    value       = "value2"
    description = "second value"
    tag_binding = { "us-central1" : ["//run.googleapis.com/projects/9999999999999/locations/us-central1/services/hello1"] }
    }, {
    value       = "value3"
    description = "third value"
    tag_binding = {}
    }
  ]
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| key | Key for Tags | `string` | n/a | yes |
| key\_description | Description for the Key | `string` | `""` | no |
| key\_purpose | Purpose specification for the Key | `string` | `""` | no |
| key\_purpose\_data | Purpose Data specification for the key | `map(string)` | `{}` | no |
| org\_id | Organization ID | `string` | `""` | no |
| project\_number | Project Number | `string` | `""` | no |
| tag\_for | Tags Created for organization or project | `string` | `"organization"` | no |
| value\_specs | Value specifications | <pre>list(object({<br>    value       = string<br>    description = string<br>    tag_binding = map(list(string))<br>  }))</pre> | `[]` | no |

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

## TAGs IAM

Use TAGs IAM modules [tag_keys](https://github.com/terraform-google-modules/terraform-google-iam/tree/master/modules/tag_keys_iam) and [tag_values](https://github.com/terraform-google-modules/terraform-google-iam/blob/master/modules/tag_values_iam) for IAM bindings.

## Requirements

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

- [Terraform][terraform] >=v0.13
- [Terraform Provider for GCP][terraform-provider-gcp] ~> 4.0

### APIs

APIs to enabled:
- Resource Manager API: `cloudresourcemanager.googleapis.com`

## Contributing

Refer to the [contribution guidelines](./CONTRIBUTING.md) for
information on contributing to this module.

[iam-module]: https://registry.terraform.io/modules/terraform-google-modules/iam/google
[project-factory-module]: https://registry.terraform.io/modules/terraform-google-modules/project-factory/google
[terraform-provider-gcp]: https://www.terraform.io/docs/providers/google/index.html
[terraform]: https://www.terraform.io/downloads.html

## Security Disclosures

Please see our [security disclosure process](./SECURITY.md).
