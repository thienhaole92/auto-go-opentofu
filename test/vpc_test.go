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
		TerraformBinary: "tofu",
		Vars: map[string]any{
			"do_token":     os.Getenv("DO_TOKEN"),
			"project_name": "auto-go",
			"environment":  "development",
			"region":       "nyc3",
			"cidr_block":   "192.168.0.0/16",
		},
	}

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)
}
