# 04 — ADB inalámbrico (control de pantalla, sin root)

ADB permite tap/swipe/texto/screenshot, instalar/desinstalar apps y leer logs — sin root.

## En el teléfono (una vez)
1. Ajustes → Acerca del teléfono → toca **Número de compilación** 7 veces (activa Opciones de desarrollador).
2. Ajustes → Sistema → Opciones de desarrollador → activa **Depuración inalámbrica**.
3. Entra a "Depuración inalámbrica" → **Emparejar dispositivo con código**. Muestra `IP:PUERTO` + código.

## En el hub
```bash
adb pair <IP>:<PUERTO_DE_EMPAREJAMIENTO>    # pide el código de 6 dígitos
adb connect <IP>:<PUERTO_DE_CONEXION>       # el otro puerto que muestra la pantalla
adb devices                                 # debe listar el equipo como 'device'
```
El puerto de pairing y el de connect son DISTINTOS. El de pairing cambia cada vez.

## Control con IA
Con ADB conectado, un MCP server de Android (p.ej. android-mcp-server) expone estas acciones
como herramientas para que un agente controle el teléfono: screenshot → decide → tap.
