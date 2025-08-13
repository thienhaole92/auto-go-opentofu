package tofu_test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestModulePrivateKey(t *testing.T) {
	SkipIfDoTokenNotSet(t)

	t.Parallel()

	terraformOptions := &terraform.Options{
		TerraformDir:    "../examples/private_key",
		TerraformBinary: "tofu",
		Vars:            map[string]any{},
	}

	terraform.InitAndApply(t, terraformOptions)
}
