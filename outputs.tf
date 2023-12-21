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

output "key_id" {
  description = "Key ID"
  value       = google_tags_tag_key.key.id
}

output "key_name" {
  description = "Key Name"
  value       = google_tags_tag_key.key.name
}

output "key_namespaced_name" {
  description = "Key Namespaced Name"
  value       = google_tags_tag_key.key.namespaced_name
}

output "value_ids" {
  description = "List of Value Ids"
  value       = [for val in var.value_specs : google_tags_tag_value.value[val.value].id]
}

output "value_names" {
  description = "List of Value Names"
  value       = [for val in var.value_specs : google_tags_tag_value.value[val.value].name]
}

output "value_namespaced_names" {
  description = "List of Value Namespaced Names"
  value       = [for val in var.value_specs : google_tags_tag_value.value[val.value].namespaced_name]
}

output "tag_binding_ids" {
  description = "List of Tag Binding Ids"
  value       = distinct(flatten([for val in var.value_specs : [for tag_region, tag_bind in val.tag_binding : tag_region == "global" ? [for bind in tag_bind : google_tags_tag_binding.binding["${val.value}=>${bind}"].id] : []]]))
}

output "tag_binding_names" {
  description = "List of Tag Binding Names"
  value       = distinct(flatten([for val in var.value_specs : [for tag_region, tag_bind in val.tag_binding : tag_region == "global" ? [for bind in tag_bind : google_tags_tag_binding.binding["${val.value}=>${bind}"].name] : []]]))
}

output "tag_binding_location_ids" {
  description = "List of Tag Binding Location Ids"
  value       = distinct(flatten([for val in var.value_specs : [for tag_region, tag_bind in val.tag_binding : tag_region != "global" ? [for bind in tag_bind : google_tags_location_tag_binding.binding["${val.value}=>${tag_region}=>${bind}"].id] : []]]))
}

output "tag_binding_location_names" {
  description = "List of Tag Binding Location Names"
  value       = distinct(flatten([for val in var.value_specs : [for tag_region, tag_bind in val.tag_binding : tag_region != "global" ? [for bind in tag_bind : google_tags_location_tag_binding.binding["${val.value}=>${tag_region}=>${bind}"].name] : []]]))
}
