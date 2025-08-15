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
			"do_token":          os.Getenv("DIGITALOCEAN_TOKEN"),
			"project_name":      ProjectName,
			"environment":       Environment,
			"ssh_allowed":       []string{"0.0.0.0/0", "::/0"},
			"tags":              []string{},
			"allowed_tcp_ports": []int{9080,9090},
		},
	}

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)
}
