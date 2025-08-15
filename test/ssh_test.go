package tofu_test

import (
	"os"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestModuleSSH(t *testing.T) {
	SkipIfDoTokenNotSet(t)

	t.Parallel()

	terraformOptions := &terraform.Options{
		TerraformDir:    "../examples/ssh",
		TerraformBinary: TerraformBinary,
		Vars: map[string]any{
			"do_token":     os.Getenv("DIGITALOCEAN_TOKEN"),
			"project_name": ProjectName,
			"environment":  Environment,
			"ssh_keys": []map[string]string{
				{
					"name":       "test-user",
					"public_key": "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCuSLbteMpbPYSInIVO4Uhd2b+agA4JYIckdXrfLa4UvxdTwy40Kuat+TVU9Gtvm0OHLl24cQS+Gok1wd7GM2xraPZmv66vwqontQ1bTnByaImCBD8CsGJytTuh/5H8NMp3wDzk89TqlhkE7DFnVp30GYZMtdO6LjK5THUTKKLdia/LP2Z0jFIZUaRzdp2Or1F84zzg+kSgfjrOrglNf8HKPAW8NqIbS0v9aBbwMk1xw/PL47t28zws3QD02WtJ6UpkWrOQBRiSoc9v6bEUpUwghpTP/RlUHBV5W2iBrYkvW2KHml2GIhK6eNqbfnPFImwK4pKIznseCe5XHh+7LgjNUeGKtFg1eybIUGLTwHkEAPiR7nha4xVaNAweAoUMzfjyF4f1EcLwESIi2wElXCZapVt83UUhYZQrdlbNAjKgJKuAWqLDD2tDdzViq6c/X4W1Sxu8pMw0Zevv5ytCQnHGQnNJ5PKpNgQnHKYDzYVGuxRJwhKuIrkAeQox+krUINqp2Er9XD8KpDiF6Ua5+9O44MgXpB40Xs/8sgYFTsskV0N7BHbLfN6maXJCT8bwK8pXzEmLQ9Cx5Xzdvhfd7orThzAC8idYO0jtV9NibBIeV/cWcoK/+MIlu/zO6tH86ZGGBHKSWtQFJurVd4FZaXiYkuS7xqtk8mPxsz5a6SbrQQ==",
				},
			},
		},
	}

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)
}
