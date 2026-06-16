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
| `WEBHOOK_SECRET` | _(unset)_| Secret used to verify OpnForm's request signature. When unset the endpoint is open. |
| `LOG_LEVEL`      | `INFO`   | Python logging level.                                                       |

When `WEBHOOK_SECRET` is set, the server verifies the HMAC-SHA256 signature
that [OpnForm](https://docs.opnform.com/api-reference/integrations/webhook-security)
sends with every delivery:

```
X-Webhook-Signature: sha256=<hex HMAC-SHA256 of the raw request body, keyed with the secret>
```

Set the same value here and in OpnForm's webhook **Advanced → Webhook Secret**
field. Requests with a missing or invalid signature are rejected with `401`.

### Generating a secret

The secret is just a long random string. Generate one with either:

```bash
openssl rand -hex 32                                          # 64 hex chars
python -c "import secrets; print(secrets.token_urlsafe(32))"  # url-safe
```

Provide it to the container via the environment, e.g. a `.env` file next to
`docker-compose.yaml` (Compose loads it automatically):

```bash
echo "WEBHOOK_SECRET=$(openssl rand -hex 32)" >> .env
docker compose up --build
```

Use a different secret per environment, and serve behind TLS so it is not sent
in clear text.

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
