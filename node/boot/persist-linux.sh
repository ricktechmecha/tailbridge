#!/usr/bin/env bash
# Persistencia en Linux normal o proot. En Linux real usa systemd (sshd ya es servicio).
# En proot (sin systemd) arranca sshd + watchdog manualmente o desde ~/.bashrc del login.
if command -v systemctl >/dev/null && [ -d /run/systemd/system ]; then
  sudo systemctl enable --now ssh 2>/dev/null || sudo systemctl enable --now sshd
else
  # proot: no hay systemd
  pgrep -x sshd >/dev/null || (sudo /usr/sbin/sshd 2>/dev/null || /usr/sbin/sshd)
  ( while true; do pgrep -x sshd >/dev/null || (sudo /usr/sbin/sshd 2>/dev/null || /usr/sbin/sshd); sleep 30; done ) &
fi
echo "sshd persistente iniciado"
