package tofu_test

import (
	"os"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestModuleNetworking(t *testing.T) {
	SkipIfDoTokenNotSet(t)

	t.Parallel()

	terraformOptions := &terraform.Options{
		TerraformDir:    "../examples/networking",
		TerraformBinary: TerraformBinary,
		Vars: map[string]any{
			"do_token":     os.Getenv("DO_TOKEN"),
			"project_name": ProjectName,
			"environment":  Environment,
			"ssh_allowed":  []string{"0.0.0.0/0", "::/0"},
			"tags":         []string{},
		},
	}

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)
}
