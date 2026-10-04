# 01 — Transporte: Tailscale + SSH bidireccional

## Tailscale
Instala Tailscale en ambos equipos y únelos al mismo tailnet (cuenta). Quedan en una red privada
cifrada (WireGuard) aunque estén en WiFis o países distintos.

- Hub (Mac/Linux): app oficial o `tailscale up`.
- Android: app Tailscale (Play Store). Para CLI en Termux: ver tailscale-android-cli.

Verifica: `tailscale status` lista ambos con sus IPs `100.x.x.x`.

## SSH sin contraseña (llaves ed25519)
En cada lado genera llave y copia la pública al otro:

```bash
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N ""
# del nodo al hub:
cat ~/.ssh/id_ed25519.pub | ssh ${HUB_USER}@${HUB_IP} "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"
```

## ~/.ssh/config en el hub (conexión estable + multiplexado)
```
Host node
    HostName 100.y.y.y
    User tu_usuario
    Port 8022
    ServerAliveInterval 20
    ServerAliveCountMax 6
    TCPKeepAlive yes
    ControlMaster auto
    ControlPath ~/.ssh/controlmasters/%r@%h:%p
    ControlPersist 10m
```
`mkdir -p ~/.ssh/controlmasters`. Ahora `ssh node` reconecta al instante y reutiliza el canal.
