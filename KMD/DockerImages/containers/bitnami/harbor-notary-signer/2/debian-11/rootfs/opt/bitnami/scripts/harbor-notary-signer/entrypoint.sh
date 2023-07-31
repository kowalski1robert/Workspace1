#!/bin/bash
# Copyright VMware, Inc.
# SPDX-License-Identifier: APACHE-2.0

# shellcheck disable=SC1091

set -o errexit
set -o nounset
set -o pipefail
# set -o xtrace # Uncomment this line for debugging purposes

# Load libraries
. /opt/bitnami/scripts/libbitnami.sh

print_welcome_page

if [[ "$1" = "/opt/bitnami/scripts/harbor-notary-signer/run.sh" ]]; then
    info "** Starting harbor-notary-signer setup **"
    /opt/bitnami/scripts/harbor-notary-signer/setup.sh
    info "** harbor-notary-signer setup finished! **"
fi

echo ""
exec "$@"
