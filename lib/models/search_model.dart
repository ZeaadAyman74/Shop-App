class SearchModel {
  late bool status;
  String? message;
  SearchData? data;

  SearchModel(Map<String, dynamic>json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? SearchData(json['data']) : null;
  }
}

class SearchData {
  List<Product>data = [];

  SearchData(Map<String, dynamic>json) {
    json['data'].forEach((element) {
      data.add(Product(element));
    });
  }
}

class Product {
  late int productId;
  String? image;
  dynamic price;
  String? name;
  String? description;
  late bool inFavorites;
  late bool inCart;

  Product(Map<String, dynamic>json) {
    productId =json['id'];
        name =json['name'];
        image =json['image'];
        price =json['price'];
        description =json['description'];
        inFavorites =json['in_favorites'];
        inCart=json['in_cart'];
  }
}