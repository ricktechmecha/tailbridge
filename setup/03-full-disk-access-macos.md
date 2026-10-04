# 03 — Acceso total al disco (Full Disk Access) en macOS

En macOS, carpetas como `~/Documents`, `~/Desktop`, `~/Downloads` están protegidas por TCC.
Un proceso lanzado por SSH o por un agente NO las ve hasta que le das **Full Disk Access (FDA)**.

Ruta: **Ajustes del Sistema → Privacidad y Seguridad → Acceso total al disco**.

## Qué añadir (y por qué)
1. **`/usr/libexec/sshd-keygen-wrapper`** — es el programa que atiende las conexiones SSH entrantes
   (está en `/System/Library/LaunchDaemons/ssh.plist`). Dándole FDA, **cualquier** comando que el
   nodo ejecute por SSH en el hub puede tocar todo el disco.
   Para añadirlo: en el panel FDA pulsa `+`, pulsa `Cmd+Shift+G` y pega la ruta.
2. **Tu terminal** (Terminal.app, iTerm, o VS Code si lo usas) — para cuando lanzas cosas en local.
3. **El binario de tu agente/CLI** si corre bajo launchd (no bajo tu terminal). Añade el ejecutable
   real. Si está firmado con Developer ID, el permiso sobrevive a las actualizaciones de versión.

## Verificar
Tras añadirlos, reinicia Remote Login (Ajustes → General → Compartir → Inicio de sesión remoto,
apágalo y enciéndelo) para que los nuevos permisos apliquen a sesiones SSH.
