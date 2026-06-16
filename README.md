# forms-sheets-webhook-server

Flask webhook server that receives form submissions on `POST /webhook` and
persists them to per-form Excel workbooks under `/data`.

## Development

Dependencies are managed with [uv](https://docs.astral.sh/uv/).

```bash
uv sync              # create .venv and install locked dependencies
uv run app.py        # run the dev server (http://localhost:5000)
```

Common dependency tasks:

```bash
uv add <package>     # add a dependency (updates pyproject.toml + uv.lock)
uv lock --upgrade    # refresh the lockfile to newer compatible versions
uv sync              # apply the lockfile to .venv
```

## Container

```bash
docker compose up --build
```
