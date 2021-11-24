import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginController extends ChangeNotifier {

  GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController idController = TextEditingController();
  TextEditingController pwController = TextEditingController();

  final storage = FlutterSecureStorage();
}