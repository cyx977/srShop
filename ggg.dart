import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  try {
    try {
      const url = "https://srshop-28285.firebaseio.com/products.json/";
      var response = await http.get(url);
      print("${response.body} body");
      var responseJson = jsonDecode(response.body) as Map<String, dynamic>;
      print(responseJson);
    } catch (e) {
      print("E");
      throw e;
    } finally {
      print("done everything");
    }
  } catch (eee) {
    print("EEE");
    print(eee);
  }
}
