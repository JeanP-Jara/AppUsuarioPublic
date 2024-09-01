import 'package:app_all_one/Model/UserClass.dart';
import 'package:app_all_one/data/Tablas/TablaUsuario.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class BD{
  static Future<Database> openBD() async {
    return openDatabase(p.join(await getDatabasesPath(), 'app.db'),
        onCreate: (db, version) {
          db.execute(
              "CREATE TABLE ${TablaUsuario.NOMBRE_TABLA} "
                  " ( "
                  " ${TablaUsuario.ID} INTEGER PRIMARY KEY, "
                  " ${TablaUsuario.NOMBRE} TEXT, "
                  " ${TablaUsuario.USUARIO} TEXT, "
                  " ${TablaUsuario.IMAGEN} TEXT, "
                  " ${TablaUsuario.SEGUIR} TEXT, "
                  " ${TablaUsuario.SINCRONIZAR} TEXT "
                  " ); "
          );
        },
        version: 1
    );
  }

  static Future<int> insertUser( User user) async {
    Database db = await openBD();
    int insert = 0;
    insert = await db.insert(TablaUsuario.NOMBRE_TABLA, user.toMap());
    db.close();
    return insert;
  }

  static Future<List<User>> getUser() async {
    Database db = await openBD();
    final List<Map<String, dynamic>> listUser = await db.query(TablaUsuario.NOMBRE_TABLA);

    return List.generate(listUser.length,
            (i) => User(
                id: listUser[i][TablaUsuario.ID],
                name: listUser[i][TablaUsuario.NOMBRE],
                username: listUser[i][TablaUsuario.USUARIO],
                image: listUser[i][TablaUsuario.IMAGEN],
                isFollowedByMe: listUser[i][TablaUsuario.SEGUIR] == '1' ? true : false,
                sincronizar: listUser[i][TablaUsuario.SINCRONIZAR]
            )
    );
  }

  static Future<int> deleteUser( User user) async {
    Database db = await openBD();
    int delete = 0;
    delete = await db.delete(TablaUsuario.NOMBRE_TABLA, where: "${TablaUsuario.ID} = ${user.id}");
    db.close();
    return delete;
  }

  static Future<int> updateUser( User user ) async {
    Database db = await openBD();
    int update = 0;
    update = await db.update(TablaUsuario.NOMBRE_TABLA, user.toMap(), where: " ${TablaUsuario.ID} = ${user.id}");
    return update;
  }

  static Future<List<User>> getUserGuardados() async {
    Database db = await openBD();
    final List<Map<String, dynamic>> listUser = await db.query(TablaUsuario.NOMBRE_TABLA, where: "${TablaUsuario.SINCRONIZAR} = '0'");

    return List.generate(listUser.length,
            (i) => User(
            id: listUser[i][TablaUsuario.ID],
            name: listUser[i][TablaUsuario.NOMBRE],
            username: listUser[i][TablaUsuario.USUARIO],
            image: listUser[i][TablaUsuario.IMAGEN],
            isFollowedByMe: listUser[i][TablaUsuario.SEGUIR] == '1' ? true : false,
            sincronizar: listUser[i][TablaUsuario.SINCRONIZAR]
        )
    );
  }

  static Future<List<User>> getUserSincronizados() async {
    Database db = await openBD();
    final List<Map<String, dynamic>> listUser = await db.query(TablaUsuario.NOMBRE_TABLA, where: "${TablaUsuario.SINCRONIZAR} = '1'");

    return List.generate(listUser.length,
            (i) => User(
            id: listUser[i][TablaUsuario.ID],
            name: listUser[i][TablaUsuario.NOMBRE],
            username: listUser[i][TablaUsuario.USUARIO],
            image: listUser[i][TablaUsuario.IMAGEN],
            isFollowedByMe: listUser[i][TablaUsuario.SEGUIR] == '1' ? true : false,
            sincronizar: listUser[i][TablaUsuario.SINCRONIZAR]
        )
    );
  }

  static Future actualizarEstado(List<User> listUsers) async {
    Database db = await openBD();
    Batch batch = db.batch();
    for(var i in listUsers){

        db.rawUpdate( "update ${TablaUsuario.NOMBRE_TABLA} SET ${TablaUsuario.SINCRONIZAR} = '1' WHERE ${TablaUsuario.ID} = ${i.id}" );

    }
    await batch.commit(noResult: true, continueOnError: true);

  }
}