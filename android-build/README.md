# android-build — Build de Android reproducible por SSH

Lecciones para que `./gradlew assembleDebug` funcione **igual en local y por SSH** (shell no
interactivo), que es donde casi todos fallan:

## 1. `ANDROID_HOME` no existe en shell no interactivo
Si defines `ANDROID_HOME` en `.zshrc`/`.bashrc`, SSH no lo carga. Solución: crea
`local.properties` en la raíz del proyecto Android:
```
sdk.dir=/ruta/al/Android/sdk
```

## 2. El JDK importa — fíjalo en el proyecto
Gradle + Android Gradle Plugin (AGP) exigen un rango de JDK concreto:
- JDK demasiado nuevo → `Unsupported class file major version XX` al compilar los build scripts.
- JDK demasiado viejo → AGP no arranca.
Para AGP 8.7, usa **JDK 21 (LTS)**. Fíjalo para no depender del PATH:
```properties
# gradle.properties
org.gradle.java.home=/ruta/al/jdk-21/Contents/Home
```
Instalar un JDK sin sudo: descarga el tarball de Temurin a `~/.jdks/` y descomprime.

## 3. Firma de release para apps instalables
`assembleRelease` sin firma produce un APK que Android rechaza. Crea un keystore y configúralo
(mantén el keystore y sus contraseñas FUERA del repo — ver `.gitignore`):
```groovy
signingConfigs { release { storeFile file("../keystore/release.keystore"); storePassword "..."; keyAlias "..."; keyPassword "..." } }
buildTypes { release { signingConfig signingConfigs.release } }
```

## 4. Verifica en entorno limpio
```bash
env -i HOME=$HOME PATH=/usr/bin:/bin ./gradlew clean assembleRelease --no-daemon
```
Si pasa con el entorno vacío, pasará por SSH.
