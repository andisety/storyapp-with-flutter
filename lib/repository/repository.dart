import 'dart:convert';
import 'package:story_app/utils/Authmanager.dart';
import '../model/model.dart';
import 'package:http/http.dart' as http;

class Repository {
  final baseUrl = "https://story-api.dicoding.dev/v1";
  final Map<String, String> headers = {'Content-Type': 'application/json'};

  Future<LoginResponse> login(String email, String password) async {
    try {
      // Map data = {'email': email, 'password': password};
      final response = await http.post(Uri.parse("$baseUrl/login"),
          headers: headers,
          body: jsonEncode(
              <String, String>{'email': email, 'password': password}));

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final responseLogin = LoginResponse.fromJson(responseData);

        AuthManager.saveAuthToken(responseLogin.loginResult.token);
        print("login sukses");
        print("token:${responseLogin.loginResult.token}");
        return responseLogin;
      } else {
        throw Exception(
            'HTTP request failed with status: ${response.statusCode} with error ${response.body}');
      }
    } catch (e) {
      print('An error occurred while making the HTTP request: $e');
      throw e;
    }
  }

  Future<ResponseApi> register(
      String name, String email, String password) async {
    try {
      // Map data = {'name': name, 'email': email, 'password': password};
      final response = await http.post(Uri.parse("$baseUrl/register"),
          headers: headers,
          body: jsonEncode(<String, String>{
            'name': name,
            'email': email,
            'password': password
          }));

      if (response.statusCode == 201) {
        final Map<String, dynamic> register = json.decode(response.body);
        print("register sukses");
        return ResponseApi.fromJson(register);
      } else {
        throw Exception(
            'HTTP request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('An error occurred while making the HTTP request.');
    }
  }

  Future<List<ListStory>> getStory() async {
    final url = '$baseUrl/stories';

    final token = await AuthManager.getAuthToken();
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final List<dynamic> storiesJson = responseData['listStory'];
        final List<ListStory> stories = storiesJson.map((storyJson) {
          return ListStory.fromJson(storyJson);
        }).toList();

        return stories;
      } else {
        throw Exception(
            'HTTP request failed with status: ${response.statusCode}, with : ${response.body}');
      }
    } catch (e) {
      print('An error occurred while making the HTTP request.');
      throw e;
    }
  }
}
