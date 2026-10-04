#!/data/data/com.termux/files/usr/bin/bash
# Persistencia en Android/Termux. Colocar en ~/.termux/boot/ (requiere Termux:Boot).
export SVDIR=$PREFIX/var/service
termux-wake-lock 2>/dev/null                       # evita que Android mate Termux
pgrep -f runsvdir >/dev/null || (runsvdir $PREFIX/var/service >/dev/null 2>&1 &)
sleep 2
sv-enable sshd 2>/dev/null || sshd                  # sshd gestionado por runit o fallback
# Watchdog: revive sshd si se cae
( while true; do pgrep -x sshd >/dev/null || sshd; sleep 30; done ) &
# Tailscale en userspace (si está instalado en Termux)
command -v tailscaled >/dev/null && { pgrep -f tailscaled >/dev/null || (tailscaled --tun=userspace-networking & sleep 2; tailscale up); }
echo "$(date) persist OK" >> ~/.termux/boot/boot.log
