# Seguridad

## Modelo
- **Transporte**: Tailscale (WireGuard, cifrado punto a punto) + SSH con llaves ed25519. Sin passwords.
- **Autenticación**: solo equipos de tu tailnet. Sin exposición a internet público.

## Checklist recomendado
- [ ] SSH solo con llave: en el hub, `PasswordAuthentication no` en `sshd_config`.
- [ ] Firewall del hub activado; expón servicios solo en la interfaz de Tailscale (`100.x`).
- [ ] **ACLs de Tailscale**: limita qué equipo puede SSH a cuál y a qué puertos.
- [ ] Cifrado de disco activado (FileVault / LUKS).
- [ ] Llaves y keystores fuera del repo (ver `.gitignore`).
- [ ] Battery optimization del nodo configurada, pero sin rootear equipos con datos sensibles.
- [ ] Revisa periódicamente `~/.ssh/authorized_keys` en ambos lados.
- [ ] Tailscale key expiry activo; rota llaves si pierdes un equipo (desde la consola de Tailscale).

## Qué NO hacer
- No publiques tu `.env`, IPs reales, ni la topología de tu red.
- No uses este toolkit en redes o equipos ajenos.
- No desactives la verificación de host de SSH "para que sea más fácil".
