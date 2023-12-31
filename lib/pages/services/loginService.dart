import 'package:TeraFlex/pages/classes/decodeJWT.dart';
import 'package:TeraFlex/pages/classes/environment.dart';
import 'package:TeraFlex/pages/classes/sharedPreferences.dart';
import 'package:TeraFlex/pages/interfaces/credentialsInterface.dart';
import 'package:TeraFlex/pages/interfaces/loginInformationInterface.dart';
import 'package:TeraFlex/pages/services/myInfoService.dart';
import 'package:TeraFlex/pages/services/notificationService.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:TeraFlex/pages/classes/firebaseApi.dart';
import 'package:TeraFlex/pages/classes/alerts.dart';

Future<String> loginService(Credentials credentials) async {
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': '*/*',
    'identification': credentials.user,
    'password': credentials.password
  };
  final body = jsonEncode({});

  try {
    final response = await http.post(
        Uri.parse('${getVariableAPI()}/auth/login'),
        body: body,
        headers: headers);
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      await saveString('token', jsonResponse['data']['token']);
      LoginInformation decoded =
          decodificarToken(jsonResponse['data']['token']);
      await saveString('idUser', decoded.id.toString());
      await saveString('docNumber', decoded.docNumber);
      if (decoded.role != 'PATIENT') {
        return 'NO_GRANTED';
      }
      getToken().then((value) {
        saveString("tokenNotification", value ?? "");
      });
      getDevideID().then((value) {
        saveString("imei", value);
        saveDevice();
        configureFirebaseMessaging();
      });
      await myInfoService();
      return 'OK';
    } else {
      return jsonResponse['error'];
    }
  } catch (error) {
    return error.toString();
  }
}
