// Copyright 2022 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package multiple_buckets

import (
	"fmt"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/stretchr/testify/assert"
	"testing"
)

func TestSimpleExample(t *testing.T) {
	tags := tft.NewTFBlueprintTest(t)

	tags.DefineVerify(func(assert *assert.Assertions) {
		tags.DefaultVerify(assert)

		projectID := tags.GetStringOutput("project_id")
		gcloudArgsForGetKeys := gcloud.WithCommonArgs([]string{"--parent", fmt.Sprintf("projects/%s", projectID), "--format=json"})
		//get created key
		opKeys := gcloud.Run(t, "resource-manager tags keys list", gcloudArgsForGetKeys).Array()[0]
		keyName := opKeys.Get("name").String()
		projectNumber := opKeys.Get("parent").String()

		assert.Equal("key1", opKeys.Get("shortName").String(), "Assert key name")

		//get values for created key
		gcloudArgsForGetValues := gcloud.WithCommonArgs([]string{"--parent", keyName, "--format=json"})
		opValues := gcloud.Run(t, "resource-manager tags values list", gcloudArgsForGetValues)

		//get values defined in terraform
		values := opValues.Get("#.shortName").Array()

		assert.ElementsMatch([2]string{"value3", "value1"}, [2]string{values[0].String(), values[1].String()}, "check if value1 and value3 exists")

		//get project value binding
		gcloudArgsBinding := gcloud.WithCommonArgs([]string{"--parent", fmt.Sprintf("//cloudresourcemanager.googleapis.com/%s",projectNumber), "--format=json"})
		opBindingValue := gcloud.Run(t, "resource-manager tags bindings list", gcloudArgsBinding).Array()[0].Get("tagValue").String()

		//get permanent_ID for value1
		opValueId := opValues.Get("#(shortName==\"value1\").name").String()

		assert.Equal(opBindingValue, opValueId, "Equate binded value with value1")


	})
	tags.Test()
}
