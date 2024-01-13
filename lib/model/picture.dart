import 'dart:io';

import 'package:image_picker/image_picker.dart';

class Picture {
  int? id;
  File? picture;
  String? token;

  Picture({
    this.id,
    this.picture,
    this.token
  });

  factory Picture.fromJson(Map<String, dynamic> json){
    return Picture(
        id: json['picture']['id'],
        picture: json['picture']['picture'],
        token: json['token']
    );
  }
}