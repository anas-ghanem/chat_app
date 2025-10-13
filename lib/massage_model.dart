import 'package:chat_app/conset.dart';

class Massage {
  final String massage;
  final String id;

  Massage(this.massage, this.id);
  factory Massage.fromJson(json) {
    return Massage(json[kmassage],json["id"]);
  }
}
