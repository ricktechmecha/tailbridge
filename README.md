# tailbridge

**Control bidireccional entre tu computadora (hub) y un equipo remoto (nodo) sobre Tailscale + SSH.**
El nodo puede ser Android/Termux, un Linux dentro de Android (proot) o un Linux normal.

> El hub es el cerebro (potencia, disco, agentes/CLIs). El nodo aporta su red, sensores y ubicación,
> y sirve como control remoto del hub. Pensado para orquestar un agente/CLI que vive en el hub desde
> el teléfono, y para que el hub use recursos del nodo (p.ej. su WiFi) cuando conviene.

## Qué hace
- 📱↔💻 Archivos y comandos en ambos sentidos (`to-node`, `from-node`, `on-node`, `find-on-node`).
- 🧠 Desde el nodo controlas una sesión persistente en el hub (`node/wrappers/hub`).
- 🌐 **Escáner de red híbrido** (`net-scan`): descubre hosts usando la red del *nodo*, el análisis
  corre en el *hub*. Útil cuando el nodo está en otra red que el hub no alcanza. (Solo redes propias.)
- 📲 Build de Android reproducible por SSH (ver `android-build/`).
- 🤖 Base para control del teléfono con IA vía ADB + un MCP server (ver `setup/04-adb-wireless.md`).
- 🐧 Funciona en Linux real o en proot dentro de Android (`setup/05-proot-linux.md`).

## Requisitos
- **Hub**: macOS o Linux con SSH server, `bash`, `scp`, y Tailscale.
- **Nodo**: Android (Termux de F-Droid), Linux en proot, o Linux normal. Con SSH server y Tailscale.
- **Tailscale** en ambos equipos (cuenta gratuita, hasta 100 dispositivos).
- Opcional: `nmap` (para `net-scan`), `mosh` (roaming), ADB (control de pantalla).

## Instalación rápida
```bash
git clone <este-repo> tailbridge && cd tailbridge
cp .env.example .env && $EDITOR .env        # pon tus IPs/usuarios
# en el nodo:
scp -r node/ <nodo>:~/tailbridge-node && ssh <nodo> "bash ~/tailbridge-node/bootstrap.sh"
# usa los scripts del hub:
export PATH="$PWD/bin:$PATH"
on-node "uname -a"
net-scan
```

## Setup paso a paso
1. [`setup/01-tailscale-ssh.md`](setup/01-tailscale-ssh.md) — red + SSH sin password + config estable
2. [`setup/02-persistence-android.md`](setup/02-persistence-android.md) — que el SSH no se muera
3. [`setup/03-full-disk-access-macos.md`](setup/03-full-disk-access-macos.md) — acceso a disco en macOS
4. [`setup/04-adb-wireless.md`](setup/04-adb-wireless.md) — control de pantalla sin root
5. [`setup/05-proot-linux.md`](setup/05-proot-linux.md) — Linux completo en Android

## Seguridad
- Todo el tráfico va cifrado por Tailscale (WireGuard) + SSH con llaves ed25519.
- `.env`, llaves y keystores están en `.gitignore`. **Nunca** subas secretos.
- Restringe el acceso con ACLs de Tailscale. No rootees un equipo con datos sensibles.
- Revisa `SECURITY.md`.

## Por qué existe
Hay proyectos para el *transporte* (tailssh, tailscale-android-cli). tailbridge añade encima la
*orquestación*: archivos/comandos bidireccionales, escaneo híbrido, build reproducible y control
con IA, con el mismo set de scripts para Android, proot y Linux.

MIT. Sin garantías. Úsalo solo en equipos y redes propias.
