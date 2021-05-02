# diesel-cli-action

This GitHub action runs `diesel database setup` within the given working directories.

## Example Worklow
```yaml
name: Rust Project Example

on: [push, pull_request]

env:
  CARGO_TERM_COLOR: always

jobs:
  test:
    name: Test
    runs-on: ubuntu-latest
    services:
      postgres:
        image: postgres
        env:
          POSTGRES_HOST_AUTH_METHOD: trust
          POSTGRES_USER: runner
        options: >-
            --health-cmd pg_isready
            --health-interval 10s
            --health-timeout 5s
            --health-retries 5
        ports:
          - 5432:5432
    steps:
      - uses: actions/checkout@v2
      - uses: actions-rs/toolchain@v1
        with:
          profile: minimal
          toolchain: stable
          override: true
      - name: Provision the database
        uses: docker://kenaniah/diesel-cli-action:v1
        env:
          WORKING_DIRECTORIES: db/
          DATABASE_URL: postgres://runner@postgres/testing_db
      - uses: actions-rs/cargo@v1
        with:
          command: test
```

## Provisioning Multiple Databases

If you have multiple databases that are managed by diesel, you can pass in multiple working directories separated by a comma, like below:

```yaml
# ...
      - name: Provision each database
        uses: docker://kenaniah/diesel-cli-action:v1
        env:
          WORKING_DIRECTORIES: first_db/,second_db/
```
