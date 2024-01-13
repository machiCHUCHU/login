class User {
  int? id;
  String? name;
  String? email;
  String? region;
  String? province;
  String? city;
  String? brgy;
  String? token;

  User({
    this.id,
    this.name,
    this.email,
    this.region,
    this.province,
    this.city,
    this.brgy,
    this.token
  });

  factory User.fromJson(Map<String, dynamic> json){
    return User(
        id: json['user']['id'],
        name: json['user']['name'],
        email: json['user']['email'],
        region: json['user']['region'],
        province: json['user']['province'],
        city: json['user']['city'],
        brgy: json['user']['brgy'],
        token: json['token']
    );
  }
}