package tofu_test

import (
	"os"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestModuleDroplet(t *testing.T) {
	SkipIfDoTokenNotSet(t)

	t.Parallel()

	terraformOptions := &terraform.Options{
		TerraformDir:    "../examples/droplet",
		TerraformBinary: "tofu",
		Vars: map[string]any{
			"do_token":       os.Getenv("DO_TOKEN"),
			"project_name":   "auto-go",
			"environment":    "development",
			"vpc_uuid":       "",
			"region":         "nyc1",
			"instance_count": 1,
			"instance_size":  "s-1vcpu-1gb-amd",
			"os_image":       "ubuntu-25-04-x64",
			"ssh_keys":       []string{},
		},
	}

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)
}
