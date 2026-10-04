# 05 — Linux completo en el nodo con proot-distro (Android sin root)

`proot-distro` instala una distro Linux real (Debian/Ubuntu/Arch…) **dentro de Termux, sin root**.
Esto da glibc real: corre binarios que no existen para Termux (Node oficial, Claude Code nativo,
herramientas que esperan un Linux estándar). Es la base para que tailbridge funcione igual en
cualquier equipo Linux.

## Instalar

```bash
pkg install -y proot-distro
proot-distro install debian          # o: ubuntu, archlinux
proot-distro login debian            # entras al Linux
```

Dentro de Debian ya tienes `apt`:

```bash
apt update && apt install -y openssh-server nmap tmux mosh rsync
```

## SSH dentro del proot

proot no tiene systemd. Arranca sshd a mano (usa un puerto distinto al de Termux, p.ej. 8023):

```bash
mkdir -p /run/sshd
ssh-keygen -A
/usr/sbin/sshd -p 8023
```

Desde el hub conectas al proot a través del Termux host:
- Opción simple: entra a Termux por 8022 y luego `proot-distro login debian`.
- Opción directa: reenvía el 8023 del proot al exterior con un `socat`/túnel, o corre el sshd
  del proot escuchando y accede por `ssh -p 8023`.

## Arranque automático del proot al boot

En `~/.termux/boot/01-proot.sh` (Termux:Boot):

```bash
#!/data/data/com.termux/files/usr/bin/bash
proot-distro login debian -- bash -c '/usr/sbin/sshd -p 8023; sleep infinity' &
```

## Por qué importa para el proyecto

- En un **Linux normal** tailbridge usa `NODE_KIND=linux` y `apt`/systemd directo.
- En **Android** usas `NODE_KIND=proot` (glibc) o `NODE_KIND=termux` (nativo Termux).
- Los scripts de `node/bootstrap.sh` detectan el entorno y se adaptan.

> proot tiene overhead (es emulación de syscalls). Para tareas pesadas, el hub sigue siendo
> quien hace el trabajo; el nodo aporta su red, sensores y ubicación.
