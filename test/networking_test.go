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
		TerraformBinary: "tofu",
		Vars: map[string]any{
			"do_token":     os.Getenv("DO_TOKEN"),
			"project_name": "auto-go",
			"environment":  "development",
			"ssh_allowed":  []string{"0.0.0.0/0", "::/0"},
			"tags":         []string{},
		},
	}

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)
}
