#!/usr/bin/env bash
# Installs checkov and tflint. Never fails: a failed install must not stop
# the Codespace from running postStartCommand (which starts Floci).

echo "Installing checkov..."
pip install --user checkov \
  || pipx install checkov \
  || echo "WARNING: checkov install failed - rerun: pip install --user checkov"

echo "Installing tflint..."
curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash \
  || echo "WARNING: tflint install failed - rerun: bash .devcontainer/install-tools.sh"

exit 0
