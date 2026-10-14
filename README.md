# RutaCastor

Asistente de navegación y supervivencia universitaria para la comunidad de la
Universidad Tecnológica de Puebla (UTP): mapa interactivo del campus,
seguimiento de trámites escolares con alertas y un copiloto de IA (RAG) para
resolver dudas sobre reglamentos y servicios.

## Estado del proyecto (Sprint 1 — módulo de autenticación)

Este scaffold cubre lo planeado para el Sprint 1 hasta el 19-sep:

- **Proyecto Flutter**: estructura `lib/{models,screens,services,widgets,utils,theme}`,
  `pubspec.yaml` con `firebase_core`, `firebase_auth`, `cloud_firestore`,
  `provider`, `go_router`, `dio`, `shared_preferences`, `flutter_secure_storage`.
- **Tema**: paleta, tipografía y `ThemeData` en `lib/theme/app_theme.dart`.
- **Modelos**: `Usuario`, `Rol`, `Permiso` con `fromMap` / `toMap`.
- **Servicios**: `AuthService` (registro, login, logout, cambio de contraseña,
  recuperación), `UsuarioService` (CRUD), `StorageService` (sesión local con
  `flutter_secure_storage`).
- **Pantallas**: Splash, Login, Registro, Home, Perfil, Cambiar Contraseña,
  Lista de Usuarios (admin).
- **Widgets reutilizables**: `CustomTextField`, `CustomButton`,
  `LoadingIndicator`, `ErrorDialog`.
- **Validaciones**: correo, contraseña (mínimo 8 caracteres), campos
  obligatorios, coincidencia de contraseñas, matrícula, teléfono
  (`lib/utils/validators.dart`).

## Pendiente (según cronograma, 21–25 sep)

- Pantalla Detalle de Usuario (admin).
- Navegación con `go_router` y restricción de pantallas por rol (hoy usa
  `Navigator` con rutas nombradas como base).
- Manejo de errores centralizado y mensajes al usuario.
- Cierre de sesión con limpieza de datos (ya implementado en `AuthService.logout`,
  falta integrarlo a la navegación protegida).
- Pruebas de registro, login, cambio de contraseña, restricción por rol,
  navegación y persistencia de sesión.
- Documentación de pantallas, servicios y estructura de Firestore.

## Cómo correr el proyecto

1. Instala las dependencias:
   ```bash
   flutter pub get
   ```
2. Para probar las pantallas sin configurar Firebase, ejecuta el modo demo:
   ```bash
   flutter run -d edge --dart-define=RUTACASTOR_DEMO=true
   ```
   También puedes usar otro dispositivo Flutter en lugar de `edge`. El modo
   demo permite entrar como invitado y usa datos de ejemplo en memoria; login,
   registro y cambios de contraseña requieren Firebase.
3. Para usar Firebase, configura el proyecto siguiendo el checklist de abajo
   y ejecuta la app sin `RUTACASTOR_DEMO`:
   ```bash
   flutter run -d android
   ```

## Configuración de Firebase (checklist)

- [ ] Proyecto creado en Firebase Console
- [ ] App Android registrada (package `com.utp.rutacastor` o el que definan) con SHA-1 de debug
- [ ] `google-services.json` real colocado en `android/app/` (el `.gitignore` ya lo excluye)
- [ ] Authentication → método **Correo electrónico/contraseña** habilitado
- [ ] Firestore Database creado (modo producción, región `us-central1` o la más cercana)
- [ ] Reglas publicadas desde `firestore.rules` (`firebase deploy --only firestore:rules`)
- [ ] Índices publicados desde `firestore.indexes.json` (`firebase deploy --only firestore:indexes`)
- [ ] `flutterfire configure` ejecutado → genera `lib/firebase_options.dart`
- [ ] Colecciones `roles` y `permisos` sembradas con `scripts/seed_roles_permisos.js`

## Estructura de Firestore (colección `usuarios`)

```
usuarios/{uid}
  nombre: string
  apellido: string
  correo: string
  matricula: string
  telefono: string
  rol: "admin" | "alumno" | "staff"
  activo: boolean
```

Colecciones `roles/{id}` y `permisos/{id}` siguen la misma lógica de
`fromMap`/`toMap` definida en `lib/models/rol.dart` y `lib/models/permiso.dart`.

## Módulo de espacios

La pantalla **Espacios** consulta `espacios` en tiempo real, con filtros por
edificio y categoría y búsqueda local por nombre. Cada documento contiene
`nombre`, `descripcion`, `edificioId` y `categoriaId`, además de `imagenUrl`
opcional. Los IDs referencian documentos de `edificios` y `categorias`.

El servicio Firestore está en
`lib/features/espacios/data/services/espacio_service.dart`. Las reglas permiten
lectura a usuarios autenticados y reservan las escrituras de espacios para
administradores. La app incluye lista y detalle; las operaciones CRUD se
exponen mediante el servicio. El modo demo usa datos en memoria y no requiere Firebase.
Para el modo Firebase, crea primero los documentos referenciados en
`edificios` y `categorias`, revisa y publica las reglas de `firestore.rules`,
y luego usa una sesión administradora para escribir espacios.
