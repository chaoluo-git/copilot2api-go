#!/bin/sh
set -eu

custom_ca_dir=/run/copilot/custom-cas
installed_custom_ca=false

if [ -d "$custom_ca_dir" ]; then
	for cert in "$custom_ca_dir"/*.crt; do
		[ -f "$cert" ] || continue
		name=$(basename "$cert")
	cp "$cert" "/usr/local/share/ca-certificates/copilot-$name"
		installed_custom_ca=true
	done
fi

if [ "$installed_custom_ca" = true ]; then
	update-ca-certificates
	# The Go service uses the system trust bundle. Pass the same bundle to the
	# Node-based Copilot CLI runtime spawned by the SDK.
	export NODE_EXTRA_CA_CERTS=/etc/ssl/certs/ca-certificates.crt
fi

exec /app/copilot-go "$@"
