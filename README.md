# forms-sheets-webhook-server

Flask webhook server that receives form submissions on `POST /webhook` and
persists them to per-form Excel workbooks under `/data`.

## Development

Dependencies are managed with [uv](https://docs.astral.sh/uv/).

```bash
uv sync              # create .venv and install locked dependencies
mkdir -p data        # local output folder
EXCEL_FOLDER=./data uv run app.py   # run the dev server (http://localhost:5000)
```

## Configuration

| Variable         | Default  | Description                                                                 |
| ---------------- | -------- | --------------------------------------------------------------------------- |
| `EXCEL_FOLDER`   | `/data`  | Directory the Excel workbooks are written to. Use `./data` for local runs.  |
| `WEBHOOK_SECRET` | _(unset)_| Shared secret required to call `/webhook`. When unset the endpoint is open. |
| `LOG_LEVEL`      | `INFO`   | Python logging level.                                                       |

When `WEBHOOK_SECRET` is set, callers must present it in one of these ways:

```
X-Webhook-Secret: <secret>
Authorization: Bearer <secret>
POST /webhook?secret=<secret>
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
