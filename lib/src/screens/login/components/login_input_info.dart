import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sjw_v1/src/providers/login/login_controller.dart';

class LoginInputInfo extends StatelessWidget {
  final Size? size;

  LoginInputInfo({required this.size});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: this.size!.height * 0.35,
      left: this.size!.width * 0.15,

      child: Container(
          width: this.size!.width * 0.7,
          height: this.size!. height * 0.18,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 7,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ]
          ),
          padding: EdgeInsets.all(16.0),

          child: Form(
            key: context.read<LoginController>().formKey,
            child: Column(

              children: <Widget>[

                //아이디 입력 필드
                TextFormField(
                  controller: context.read<LoginController>().idController,
                  validator: (value){
                    if(value!.trim().isEmpty){
                      return '아이디를 입력하세요.';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '아이디 입력',
                  ),
                  keyboardType: TextInputType.text,
                ),

                SizedBox(height: this.size!.height * 0.01,),

                //비밀번호 입력 필드
                TextFormField(
                  controller: context.read<LoginController>().pwController,
                  obscureText: true,
                  validator: (value){
                    if(value!.trim().isEmpty){
                      return '패스워드를 입력하세요.';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '패스워드 입력',
                  ),
                  keyboardType: TextInputType.text,
                ),
              ],
            ),
          )
      ),
    );
  }
}
