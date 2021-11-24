import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sjw_v1/main.dart';

class LogoutButton extends StatelessWidget {
  final Size? size;

  LogoutButton({this.size});

  final storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50,
      right: 10,
      child: InkWell(
        onTap: (){
          _showLogoutDialog(context);
        },
        child: Icon(Icons.logout, size: 50, color: Colors.white,),
      ),
    );
  }

  _showLogoutDialog(BuildContext context){
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text("로그아웃",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),),
          content: Text('로그아웃 하시겠습니까?',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,),),
          actions: <Widget>[
            FlatButton(
              child: Text('예'),
              onPressed: (){

                storage.delete(key: 'storageId');
                storage.delete(key: 'storagePw');

                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, a1, a2) => Home(),
                  ),
                );
              },
            ),

            FlatButton(
              child: Text('아니오'),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          ],
        );
      }
    );
  }
}
