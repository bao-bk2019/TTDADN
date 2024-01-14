import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  final double currentTemperature;
  final double currentHumidity;

  SettingsPage({required this.currentTemperature, required this.currentHumidity});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController temperatureController = TextEditingController();
  TextEditingController humidityController = TextEditingController();
  @override
  void initState() {
    super.initState();
    // Set initial values in the text controllers
    temperatureController.text = widget.currentTemperature.toString();
    humidityController.text = widget.currentHumidity.toString();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: temperatureController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Temperature'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: humidityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Humidity'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                saveSettings(context);
                 // Close the settings page
              },
              child: Text('Save Settings'),
            ),
          ],
        ),
      ),
    );
  }

  void saveSettings(BuildContext context) {
    // Add your logic to save the temperature and humidity settings
    // For example, you can use shared preferences or another storage mechanism
    double currentTemperature = double.tryParse(temperatureController.text) ?? 0.0;
    double newHumidity = double.tryParse(humidityController.text) ?? 0.0;
    Navigator.pop(context,{'temperature': currentTemperature, 'humidity': newHumidity});
    // Save the new settings using your preferred storage mechanism
    // For example, you can use shared preferences
  }
}
