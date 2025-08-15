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
		TerraformBinary: TerraformBinary,
		Vars: map[string]any{
			"do_token":       os.Getenv("DIGITALOCEAN_TOKEN"),
			"project_name":   ProjectName,
			"environment":    Environment,
			"vpc_uuid":       "",
			"region":         Region,
			"instance_count": 1,
			"instance_size":  "s-1vcpu-1gb-amd",
			"os_image":       "ubuntu-25-04-x64",
			"ssh_keys": []string{
				"77:37:9a:f3:ad:08:54:0a:e7:16:9d:bb:e2:04:45:11",
			},
		},
	}

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)
}
