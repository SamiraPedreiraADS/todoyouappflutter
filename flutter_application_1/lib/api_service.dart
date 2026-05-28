import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {

  static Future<String> buscarFrase() async {

    final response = await http.get(
      Uri.parse('https://api.adviceslip.com/advice'),
    );

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);

      return data['slip']['advice'];
    }

    return 'Não foi possível carregar frase';
  }
}