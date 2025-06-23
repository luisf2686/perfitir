import 'dart:convert'; // Para convertir JSON <-> Map
import 'dart:io'; // Para leer/escribir archivos
import 'package:path_provider/path_provider.dart'; // Para ubicar carpetas del sistema

class UserService { //Encapsula toda la lógica relacionada con usuarios.
  static Future<File> _getUserFile() async { 
    /*Obtiene la ruta donde guardar archivos de la app.
     Devuelve un objeto File apuntando a users.json.*/
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/users.json');
  }

/*Lee el archivo users.json.
Si no existe, lo crea vacío {}.
Retorna los usuarios como un Map<email, contraseña>.*/
  static Future<Map<String, dynamic>> _readUsers() async {
    final file = await _getUserFile();
    if (!await file.exists()) {
      await file.writeAsString('{}');
    }
    final content = await file.readAsString();
    return json.decode(content);
  }

/*Lee los usuarios actuales.
Si el email ya existe, retorna false.
Si no, lo agrega y guarda el archivo actualizado.
Retorna true si el registro fue exitoso.*/
  static Future<bool> registerUser(String email, String password) async {
    final users = await _readUsers();
    if (users.containsKey(email)) return false;

    users[email] = password;
    final file = await _getUserFile();
    await file.writeAsString(json.encode(users));
    return true;
  }

/*Lee los usuarios del archivo.
Verifica si el email existe y la contraseña coincide.
Retorna true o false.*/
  static Future<bool> loginUser(String email, String password) async {
    final users = await _readUsers();
    return users[email] == password;
  }
}