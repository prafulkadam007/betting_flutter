import 'package:http/http.dart' as http;

Future<http.Response> callLoginAPI(
    {required String username, required String password}) async {
  var url = Uri.parse('https://reqres.in/api/login');
  return await http.post(url, body: {'email': username, 'password': password});
}
