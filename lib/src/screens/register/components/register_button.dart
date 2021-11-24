import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sjw_v1/src/models/user.dart';
import 'package:provider/provider.dart';
import 'package:sjw_v1/src/providers/database/database_controller.dart';
import 'package:sjw_v1/src/providers/register/register_controller.dart';

class RegisterButton extends StatelessWidget {
  final Size? size;

  RegisterButton({this.size});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: this.size!.height * 0.8,
      left: this.size!.width * 0.25,
      child: InkWell(
        onTap: (){
          var user = User(
            name: context.read<RegisterController>().nameController.text,
            id: context.read<RegisterController>().idController.text,
            pw: context.read<RegisterController>().pwController.text,
          );

          context.read<DatabaseController>().insertUser(user);

          //context.read<DatabaseController>().showUserList();

          if(context.read<RegisterController>().formKey.currentState!.validate()){
            Navigator.of(context).pop();
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
          child: Text(
            'Register',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
