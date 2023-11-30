import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<void> fetchSteamGameData() async {
    const apiKey = '37D9C03B00BDCD0B8CE03351101779AF';
    const steamApiEndpoint =
        'https://api.steampowered.com/ISteamApps/GetAppList/v2/?key=$apiKey';

    final response = await http.get(Uri.parse(steamApiEndpoint));

    if (response.statusCode == 200) {
      // Handle the data received from the API (parse JSON, etc.)
      if (kDebugMode) {
        print('Data received: ${response.body}');
      }
    } else {
      // Handle errors
      if (kDebugMode) {
        print('Error while making the request: ${response.statusCode}');
      }
    }
  }
}
