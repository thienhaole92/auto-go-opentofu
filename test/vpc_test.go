package tofu_test

import (
	"os"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestModuleVPC(t *testing.T) {
	SkipIfDoTokenNotSet(t)

	t.Parallel()

	terraformOptions := &terraform.Options{
		TerraformDir:    "../examples/vpc",
		TerraformBinary: TerraformBinary,
		Vars: map[string]any{
			"do_token":     os.Getenv("DIGITALOCEAN_TOKEN"),
			"project_name": ProjectName,
			"environment":  Environment,
			"region":       Region,
			"cidr_block":   "10.50.100.0/24",
		},
	}

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)
}
