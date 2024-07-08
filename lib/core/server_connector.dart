import 'package:http/http.dart' as http;

class ServerConnector {
  ServerConnector._();
  static final client = http.Client();
  static const baseUrl = 'https://65dd6acde7edadead7eddeb2.mockapi.io';
}
