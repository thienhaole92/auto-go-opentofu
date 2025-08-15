package tofu_test

import (
	"os"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func SkipIfDoTokenNotSet(t *testing.T) {
	if os.Getenv("DIGITALOCEAN_TOKEN") == "" {
		t.Skip("DIGITALOCEAN_TOKEN environment variable not set, skipping the test")
	}
}

func TestModuleProject(t *testing.T) {
	SkipIfDoTokenNotSet(t)

	t.Parallel()

	terraformOptions := &terraform.Options{
		TerraformDir:    "../examples/project",
		TerraformBinary: TerraformBinary,
		Vars: map[string]any{
			"do_token":     os.Getenv("DIGITALOCEAN_TOKEN"),
			"project_name": ProjectName,
			"environment":  Environment,
			"purpose":      "Golang CI-CD Pipeline Testing",
		},
	}

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)
}
