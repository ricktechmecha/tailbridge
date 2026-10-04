# 02 — Persistencia en Android: que el SSH NO se muera nunca

Android (sobre todo 15+) mata procesos en segundo plano con agresividad. Por eso el `sshd` de
Termux "se muere" al cambiar de red o dejar la app en background. Solución en capas:

## 1. Battery optimization: Unrestricted (EL PASO MÁS IMPORTANTE)
Ajustes → Apps → **Termux** → Batería → **Sin restricciones** (Unrestricted).
Repite para **Termux:Boot** y **Termux:API**. Sin esto, nada sobrevive de forma fiable.

## 2. Wake lock
`termux-wake-lock` le dice a Android "estoy trabajando, no me suspendas".
(Queda en el script de boot.)

## 3. Termux:Boot
Instala la app **Termux:Boot** (F-Droid). Ábrela UNA vez. Coloca scripts en `~/.termux/boot/`.
Usa `node/boot/persist.sh` de este repo.

## 4. runit (termux-services) + watchdog
`termux-services` da auto-restart de `sshd`. El script de boot arranca `runsvdir`, habilita
`sshd` y además deja un watchdog (`while` que revive sshd cada 30s).

## 5. mosh para roaming (WiFi ↔ datos sin cortes)
SSH se corta si cambia la IP de la red. **mosh** sobrevive cambios de red e IP.
Instala `mosh` en ambos lados y conéctate con `mosh` en vez de `ssh`.
(En macOS Intel puede requerir Xcode Command Line Tools para compilar.)

## 6. Fijar la app en recientes
En el multitarea, fija/bloquea Termux para que el "limpiador" no la cierre.

## Nota sobre validación
No puedes validar la persistencia desde una sesión SSH: los procesos en segundo plano lanzados
por SSH mueren al cerrar la sesión. La persistencia real se prueba **reiniciando el equipo**:
Termux:Boot arranca `persist.sh` en el contexto propio de Termux.
