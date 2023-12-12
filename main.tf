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

# Create Tags Key
resource "google_tags_tag_key" "key" {
  parent       = var.tag_for == "organization" ? "organizations/${var.org_id}" : var.tag_for == "project" ? "projects/${var.project_number}" : null
  short_name   = var.key
  description  = var.key_description
  purpose      = var.key_purpose
  purpose_data = var.key_purpose_data
}

# Create Tags Values for Key
resource "google_tags_tag_value" "value" {
  for_each    = { for val_desc in var.value_specs : val_desc.value => val_desc }
  parent      = "tagKeys/${google_tags_tag_key.key.name}"
  short_name  = each.key
  description = each.value.description
}

# Create Tags Binding Globally
resource "google_tags_tag_binding" "binding" {
  for_each  = toset(distinct(flatten([for val_desc in var.value_specs : [for tag_region, tag_binding in val_desc.tag_binding : tag_region == "global" ? [for bind in tag_binding : "${val_desc.value}=>${bind}"] : []]])))
  parent    = split("=>", each.value)[1]
  tag_value = "tagValues/${google_tags_tag_value.value[split("=>", each.value)[0]].name}"
}

# Create Tags Binding specific to Location
resource "google_tags_location_tag_binding" "binding" {
  for_each  = toset(distinct(flatten([for val_desc in var.value_specs : [for tag_region, tag_binding in val_desc.tag_binding : tag_region != "global" ? [for bind in tag_binding : "${val_desc.value}=>${tag_region}=>${bind}"] : []]])))
  parent    = split("=>", each.value)[2]
  tag_value = "tagValues/${google_tags_tag_value.value[split("=>", each.value)[0]].name}"
  location  = split("=>", each.value)[1]
}

