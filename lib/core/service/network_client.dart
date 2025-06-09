import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:api_market_cap_coin/configs/service_configuration.dart';

enum RequestMethod { get, post, put, delete }

class NetworkClient {
  Future<dynamic> executeRequest({
    required String endpoint,
    RequestMethod method = RequestMethod.get,
    Map<String, dynamic>? requestBody,
    Map<String, String>? additionalHeaders,
  }) async {
    final requestUrl = Uri.parse('${ServiceConfiguration.serviceEndpoint}$endpoint');
    final requestHeaders = {
      'Accepts': 'application/json',
      'X-CMC_PRO_API_KEY': ServiceConfiguration.authenticationKey,
      ...?additionalHeaders,
    };

    http.Response serverResponse;

    await Future.delayed(const Duration(seconds: 2));

    print('Request URL: $requestUrl');
    print('Request Method: $method');
    print('Request Headers: $requestHeaders');
    if (requestBody != null) {
      print('Request Body: ${jsonEncode(requestBody)}');
    }

    try {
      switch (method) {
        case RequestMethod.post:
          await Future.delayed(const Duration(seconds: 2));
          serverResponse = await http.post(requestUrl, headers: requestHeaders, body: jsonEncode(requestBody));
          break;
        case RequestMethod.put:
         await Future.delayed(const Duration(seconds: 2));
          serverResponse = await http.put(requestUrl, headers: requestHeaders, body: jsonEncode(requestBody));
          break;
        case RequestMethod.delete:
           await Future.delayed(const Duration(seconds: 2));
          serverResponse = await http.delete(requestUrl, headers: requestHeaders);
          break;
        case RequestMethod.get:
           await Future.delayed(const Duration(seconds: 2));
          serverResponse = await http.get(requestUrl, headers: requestHeaders);
          break;
      }

      print('Response Status Code: ${serverResponse.statusCode}');
      print('Response Body: ${serverResponse.body}');

      if (serverResponse.statusCode >= 200 && serverResponse.statusCode < 300) {
        return jsonDecode(serverResponse.body);
      } else {
        print('Error: ${serverResponse.statusCode} - ${serverResponse.reasonPhrase}');
        print('Error Body: ${serverResponse.body}');
        
        throw Exception('Dados não carregados: ${serverResponse.statusCode}');
      }
    } catch (e, stackTrace) {
      print('Exception during HTTP request: $e');
      print('Stack trace: $stackTrace');
      if (e == null) {
        
        throw Exception('HTTP request failed with a null error. This might be a network issue or CORS problem on web.');
      }
      
      throw Exception('Failed to execute network request: $e');
    }
  }
}