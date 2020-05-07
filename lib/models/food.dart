class Food {
  String id, createdTime, lastModifiedTime, title, description, image;
  int price;
  int quantity = 1;
  int topping = 0;
  int size = 0;

  Food({this.id,
    this.createdTime,
    this.lastModifiedTime,
    this.title,
    this.description,
    this.image,
    this.price,
    this.quantity = 1,
    this.topping = 0
  });

  Food.fromJson(Map<String, dynamic> info)
  {
    id = info['foodId'];
//    createdTime = info['createdTime'];
//    lastModifiedTime = info['lastModifiedTime'];
    title = info['title'];
    description = info['description'];
    image = info['imgURL'];
    price = info['price'];
  }

  Food.fromSizeJson(Map<String, dynamic> info){
    size = info['size'];
    price = info['price'];
  }

  Map<String, dynamic> toJson() {
    String date = DateTime.now().toString();
    return
    {
      'foodId': id,
      'createdTime': date,
      'lastModifiedTime': date,
      'size': size,
      'price':price,
      'quantity': quantity
    };
  }
}