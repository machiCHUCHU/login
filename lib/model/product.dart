class Product {
  String? pid;
  String? name;
  String? price;
  String? description;
  String? picture;
  String? status;
  String? token;

  Product({
    this.pid,
    this.name,
    this.price,
    this.description,
    this.picture,
    this.status,
    this.token
  });

  factory Product.fromJson(Map<String, dynamic> json){
    return Product(
        pid: json['product']['id'],
        name: json['product']['name'],
        price: json['product']['price'],
        description: json['product']['description'],
        picture: json['product']['picture'],
        status: json['product']['status'],
        token: json['token']
    );
  }
}