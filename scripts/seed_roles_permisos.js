/**
 * scripts/seed_roles_permisos.js
 *
 * Siembra las colecciones `roles` y `permisos` con los valores base
 * que usa RutaCastor. Se corre UNA vez (o cuando cambien los catálogos),
 * fuera de la app, usando el Admin SDK de Firebase.
 *
 * Requisitos:
 *   1. npm install firebase-admin
 *   2. Descargar una service account key desde:
 *      Firebase Console > Configuración del proyecto > Cuentas de servicio
 *      > Generar nueva clave privada
 *   3. Guardarla como scripts/serviceAccountKey.json (NO subir a git)
 *
 * Uso:
 *   node scripts/seed_roles_permisos.js
 */

const admin = require('firebase-admin');
const serviceAccount = require('./serviceAccountKey.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

const db = admin.firestore();

const roles = [
  { id: 'admin', nombre: 'Administrador', descripcion: 'Control total del sistema y usuarios' },
  { id: 'alumno', nombre: 'Alumno', descripcion: 'Alumno de nuevo ingreso o vigente en la UTP' },
  { id: 'staff', nombre: 'Staff', descripcion: 'Personal de coordinaciones y servicios escolares' },
];

const permisos = [
  { id: 'usuarios.leer', nombre: 'Leer usuarios', descripcion: 'Ver la lista y el detalle de usuarios' },
  { id: 'usuarios.editar', nombre: 'Editar usuarios', descripcion: 'Modificar datos y estado de usuarios' },
  { id: 'usuarios.eliminar', nombre: 'Eliminar usuarios', descripcion: 'Eliminar cuentas de usuario' },
  { id: 'tramites.gestionar', nombre: 'Gestionar trámites', descripcion: 'Crear y actualizar trámites y fechas límite' },
  { id: 'eventos.publicar', nombre: 'Publicar eventos', descripcion: 'Crear avisos y eventos institucionales' },
];

async function seed() {
  const batch = db.batch();

  roles.forEach((r) => {
    const { id, ...data } = r;
    batch.set(db.collection('roles').doc(id), data, { merge: true });
  });

  permisos.forEach((p) => {
    const { id, ...data } = p;
    batch.set(db.collection('permisos').doc(id), data, { merge: true });
  });

  await batch.commit();
  console.log(`Listo: ${roles.length} roles y ${permisos.length} permisos sembrados.`);
}

seed()
  .then(() => process.exit(0))
  .catch((err) => {
    console.error('Error al sembrar datos:', err);
    process.exit(1);
  });
