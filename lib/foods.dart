import 'pet.dart';

class Food extends Pet {
  String like;
  String dislike;

  Food({this.like, this.dislike});

  Food.fromJson(Map<String, dynamic> json) {
    like = json['likes'];
    dislike = json['deslikes'];
  }
}
