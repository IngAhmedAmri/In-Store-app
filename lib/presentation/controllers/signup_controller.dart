import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class SignUpController {
  Map<String, String> headers = {
    "Content-Type": "application/json",
  };
  Future<void> registerAccountWithJson(
      Map<String, dynamic> jsonBody, File image) async {
    var url = Uri.parse('http://192.168.100.12:8000/api/register');

    try {
      var uri = Uri.parse('${url}');
      var request = http.MultipartRequest("POST", uri);

      // request.fields.addAll(jsonBody);
       request.fields['json'] = jsonEncode(jsonBody);
      request.files.add(await http.MultipartFile.fromPath('image', image.path));
      request.headers.addAll(headers);
      var response = await request.send();
      var responseString = await response.stream.bytesToString();
      print(responseString);
    } on SocketException catch (e) {
      print('Erreur de connexion: $e');
    } on HttpException catch (e) {
      print('Erreur HTTP: $e');
    } on FormatException catch (e) {
      print('Format de réponse invalide: $e');
    } catch (e) {
      print('Erreur inattendue: $e');
    }
  }

  Future<void> registerAccount({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String role,
    required String acountLink,
    required String street,
    required File image,
    required String city,
    required String postCode,
    required String CIN,
    required String taxNumber,
    required String companyName,
    required bool companyUnderConstruction,
  }) async {
    var url = Uri.parse('http://192.168.100.12:8000/api/register');
    print('URL: $url'); // Affichage de l'URL dans le terminal

    try {
      var request = http.MultipartRequest('POST', url);
      request.fields.addAll({
        'name': name,
        'phone': phone,
        'email': email,
        'password': password,
        'role': 'provider-intern',
        'acountLink': acountLink,
        'street': street,
        'city': city,
        'post_code': postCode,
        'CIN': CIN,
        'TAXNumber': taxNumber,
        'companyName': companyName,
        'companyUnderConstruction': companyUnderConstruction.toString(),
      });

      request.files.add(await http.MultipartFile.fromPath('image', image.path));

      var response = await request.send();

      if (response.statusCode == 200) {
        print('Partenaire enregistré avec succès!');
      } else {
        print(
            'Erreur lors de l\'enregistrement du partenaire: ${response.statusCode}');
        print('Message d\'erreur: ${await response.stream.bytesToString()}');
      }
    } on SocketException catch (e) {
      print('Erreur de connexion: $e');
    } on HttpException catch (e) {
      print('Erreur HTTP: $e');
    } on FormatException catch (e) {
      print('Format de réponse invalide: $e');
    } catch (e) {
      print('Erreur inattendue: $e');
    }
  }
}
