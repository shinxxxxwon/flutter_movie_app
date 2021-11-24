import 'package:flutter/widgets.dart';

class RegisterController extends ChangeNotifier{

  GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController pwController = TextEditingController();

}