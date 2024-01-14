import 'package:flutter/material.dart';
import '../Data/database.dart';
import '../Screen/login.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreen createState() => _RegisterScreen();
}
class _RegisterScreen extends State<RegisterScreen> {
  final DatabaseHelper dbHelper = DatabaseHelper();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  void _registerUser() async {
    String username = _usernameController.text;
    String password = _passwordController.text;
    bool isUsernameExists = await dbHelper.isUsernameExists(username);
    if(isUsernameExists){
      _showErrorSnackBar('Tên người dùng đã tồn tại!');
    }else {
      await dbHelper.insertUser(username, password);
      _showErrorSnackBar('Đăng kí thành công!');
    }
  }


  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
// Function to handle login button press
  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng Kí Tài Khoản',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            color: Colors.red, // Set the text color to red
          ),),
        backgroundColor: Colors.lightBlue[100],
        centerTitle: true,
      ),
      backgroundColor: Colors.cyan[50] ,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child:
              Container(
                padding: EdgeInsets.all(16.0),
                child: Image.asset(
                  'assets/logo.png', // Đường dẫn đến hình ảnh trong thư mục assets
                  height: 200,
                  width: 200,// Chiều cao của hình ảnh
                ),
              ),
            ),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Tên đăng nhập',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Mật khẩu',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _registerUser(),
              child: Text('Đăng kí'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                      (route) => false,
                );
              },
              child: Text('Exit'),
            ),
          ],
        ),
      ),
    );
  }
}
