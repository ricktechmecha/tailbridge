# Contribuir a tailbridge

## Desarrollo
1. Fork → rama → PR.
2. Los scripts en `bin/` usan `set -euo pipefail` y cargan `bin/_lib.sh`.
3. No subas `.env`, llaves, IPs reales ni usuarios. Usa placeholders.
4. Verifica con `grep -rn "100\.\|u0_a\|@gmail" .` antes de commit.

## Estilo
- Bash: `#!/usr/bin/env bash`, sin dependencias exóticas.
- Markdown: español neutro o inglés, según el archivo existente.
- Un script = una responsabilidad.

## Tests
No hay suite automatizada todavía. Verifica manualmente:
```bash
cp .env.example .env  # edita con tus datos
on-node "uname -a"
to-node README.md
from-node README.md /tmp/
net-scan
```
