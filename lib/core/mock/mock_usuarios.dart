import '../../features/user/domain/entities/rol.dart';
import '../../features/user/domain/entities/usuario.dart';

/// Datos de ejemplo usados únicamente en modo invitado, para poder navegar
/// y ver las pantallas sin necesitar una sesión ni datos reales de
/// Firebase. Nada de aquí se lee ni se guarda en ningún backend.
class MockUsuarios {
  MockUsuarios._();

  static const invitado = Usuario(
    id: 'invitado',
    nombre: 'Invitado',
    apellido: '',
    correo: 'invitado@rutacastor.demo',
    matricula: '—',
    telefono: '—',
    rol: TipoRol.alumno,
    activo: true,
  );

  static const listaDemo = [
    Usuario(
      id: 'demo-1',
      nombre: 'Ana',
      apellido: 'Torres',
      correo: 'ana.torres@utp.edu',
      matricula: '2023001',
      telefono: '5512345678',
      rol: TipoRol.alumno,
    ),
    Usuario(
      id: 'demo-2',
      nombre: 'Luis',
      apellido: 'Ramírez',
      correo: 'luis.ramirez@utp.edu',
      matricula: '2023002',
      telefono: '5598765432',
      rol: TipoRol.staff,
    ),
    Usuario(
      id: 'demo-3',
      nombre: 'Carla',
      apellido: 'Mendoza',
      correo: 'carla.mendoza@utp.edu',
      matricula: '2023003',
      telefono: '5511122233',
      rol: TipoRol.admin,
      activo: false,
    ),
  ];
}
