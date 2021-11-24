import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/src/provider.dart';
import 'package:sjw_v1/src/providers/database/database_controller.dart';
import 'package:sjw_v1/src/providers/login/login_controller.dart';
import 'package:sjw_v1/src/screens/home/home_screen.dart';

class LoginButton extends StatelessWidget {
  final Size? size;

  LoginButton({required this.size});

  final storage = FlutterSecureStorage();
  String storageId = '';
  String storagePw = '';

  @override
  Widget build(BuildContext context) {

    _autoLogin(context);

    return Positioned(
      top: this.size!.height * 0.65,
      left: this.size!.width * 0.25,
      child: InkWell(
        onTap: () async {
          final textId = context.read<LoginController>().idController.text;
          final textPw = context.read<LoginController>().pwController.text;

          await context.read<DatabaseController>().getUser(textId);

          // final userNo = context.read<DatabaseController>().nNo;
          // final userNname = context.read<DatabaseController>().strName;
          final userId = context.read<DatabaseController>().strId;
          final userPw = context.read<DatabaseController>().strPw;

          if(context.read<LoginController>().formKey.currentState!.validate()){
            if (userId == textId && userPw == textPw) {
              await storage.write(key: 'storageId', value: userId);
              await storage.write(key: 'storagePw', value: userPw);

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeScreen()),
              );
           }
          } else {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('로그인 실패'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Text('아이디/패스워드가 올바르지 않습니다.'),
                          Container(
                            width: this.size!.width * 0.05,
                            height: this.size!.height * 0.1,
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                '확인',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }
        },
        child: Container(
          width: this.size!.width * 0.5,
          height: this.size!.height * 0.07,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0),
              topRight: Radius.circular(40.0),
              bottomLeft: Radius.circular(40.0),
              bottomRight: Radius.circular(40.0),
            ),
          ),
          alignment: Alignment.center,
          child: Text('Login',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )),
        ),
      ),
    );
  }

  _autoLogin(BuildContext context) async {
    storageId = (await storage.read(key: "storageId"))!;
    storagePw = (await storage.read(key: "storagePw"))!;

    if(storageId != null && storagePw != null){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => HomeScreen()),
      );
    }
  }
}
