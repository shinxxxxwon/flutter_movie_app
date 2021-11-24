
class User{
  final int? no;
  final String? name;
  final String? id;
  final String? pw;

  User({this.no, this.name, this.id, this.pw});

  Map<String, dynamic> toMap(){
    return{
      'no':no,
      'name':name,
      'id':id,
      'password':pw,
    };
  }

}