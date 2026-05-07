# Live Reducer Smoke Spec

This fixture is intentionally tiny. It exists to verify the app-server-backed
live reducer path without sending the reducer component specification.

## Boundary

The reducer MUST show app-server thread and turn events in the side rail.

The reducer SHOULD keep raw protocol messages behind diagnostics.
