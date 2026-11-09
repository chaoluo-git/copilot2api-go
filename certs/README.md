# Custom CA certificates

Place trusted enterprise or outbound TLS-inspection root certificates here as
PEM-encoded `.crt` files. The Docker entrypoint installs them into the
container's system trust store before starting the service and exposes the
updated bundle to the Copilot CLI runtime spawned by the SDK.

Only add certificates from an administrator or another source you trust. Do
not add server leaf certificates or certificates copied from an unverified
connection.
