
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

final DateTime now = DateTime.now();

  final String adafruitFan = 'https://io.adafruit.com/api/v2/baoduongsvbk/feeds/yolo-temp/data';
final String adafruitIOUrl2 = 'https://io.adafruit.com/api/v2/baoduongsvbk/feeds/yolo-temp/data/last';
final String adafruitHumidity = 'https://io.adafruit.com/api/v2/baoduongsvbk/feeds/yolo-soil/data';
  final String username = 'baoduongsvbk';
  final String aioKey = 'aio_TDqJ48JlnHpW073zOBRPTjAFNt0n';
  Future<double> fetchTemperature() async {

    final response = await http.get(
      Uri.parse('$adafruitIOUrl2?X-AIO-Key=$aioKey'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final double temperature = double.parse(data['value']);
      return temperature;
    } else {
      // Handle error
      print('Failed to fetch temperature');
      return 0.8;
    }
  }
  Future<List<Map<String, dynamic>>> getTemperature() async {
    final DateTime start = now.subtract(Duration(days: 30));

    final response2 = await http.get(
      Uri.parse('$adafruitFan?start_time=$start&end_time=$now&X-AIO-Key=$aioKey'),
    );
    if (response2.statusCode == 200) {
      List<Map<String, dynamic>> data = json.decode(response2.body).cast<Map<String, dynamic>>();
      return data;

    } else {
      List<Map<String, dynamic>> data = [];
      return data;

    }
  }
Future<List<Map<String, dynamic>>> getHumidity() async {
  final DateTime start = now.subtract(Duration(days: 30));

  final response2 = await http.get(
    Uri.parse('$adafruitHumidity?start_time=$start&end_time=$now&X-AIO-Key=$aioKey'),
  );
  if (response2.statusCode == 200) {
    List<Map<String, dynamic>> data = json.decode(response2.body).cast<Map<String, dynamic>>();
    return data;

  } else {
    List<Map<String, dynamic>> data = [];
    return data;

  }
}
String dateTimeToString(DateTime datetime) {
  final DateFormat df = new DateFormat('yyyy-MM-dd HH:mm:ss');
  return df.format(datetime);
}
