package tofu_test

import (
	"os"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func SkipIfDoTokenNotSet(t *testing.T) {
	if os.Getenv("DO_TOKEN") == "" {
		t.Skip("DO_TOKEN environment variable not set, skipping the test")
	}
}

func TestModuleProject(t *testing.T) {
	SkipIfDoTokenNotSet(t)

	t.Parallel()

	terraformOptions := &terraform.Options{
		TerraformDir:    "../examples/project",
		TerraformBinary: "tofu",
		Vars: map[string]any{
			"do_token":     os.Getenv("DO_TOKEN"),
			"project_name": "auto-go",
			"purpose":      "Golang CI-CD Pipeline Testing",
			"environment":  "development",
		},
	}

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)
}
