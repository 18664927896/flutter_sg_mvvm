


class ProductModel{

  ProductModel({
    this.name,
    this.img,
    this.num,
    this.price,
  });

  String name;
  String img;
  int num;
  double price;
  bool isCollection = false;//是否收藏


  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    name: json["name"],
    img: json["img"],
    num: json["num"],
    price: json["price"],

  );
}