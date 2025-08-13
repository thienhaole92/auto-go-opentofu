.PHONY:pre-gci
pre-gci:
	go install github.com/daixiang0/gci@latest
	
.PHONY: pre-commit
pre-commit: pre-gci
	gci write --skip-generated -s standard -s default .
	tofu fmt -diff --recursive
