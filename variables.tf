/**
 * Copyright 2021 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

variable "tag_for" {
  type        = string
  description = "Tags Created for organization or project"
  default     = "organization"
}

variable "org_id" {
  type        = string
  description = "Organization ID"
  default     = ""
}

variable "project_number" {
  type        = string
  description = "Project Number"
  default     = ""
}

variable "key" {
  description = "Key for Tags"
  type        = string
}

variable "key_description" {
  type        = string
  description = "Description for the Key"
  default     = ""
}

variable "key_purpose" {
  type        = string
  description = "Purpose specification for the Key"
  default     = ""
}

variable "key_purpose_data" {
  type        = map(string)
  description = "Purpose Data specification for the key"
  default     = {}
}

variable "value_specs" {
  type = list(object({
    value       = string
    description = string
    tag_binding = map(list(string))
  }))
  description = "Value specifications"
  default     = []
}
