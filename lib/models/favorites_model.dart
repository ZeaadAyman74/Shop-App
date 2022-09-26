class FavoritesModel {
  bool? status;
  String? message;
DataModel? data;

  FavoritesModel(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
    data=DataModel(json['data']);
  }
}

class DataModel{
  List<ProductData>?data=[];

  DataModel(Map<String,dynamic>json){
json['data'].forEach((element){
  data!.add(ProductData(element));
});
  }
}

class ProductData {
 int? id;
Products? product;

ProductData(Map<String,dynamic>json){
id=json['id'];
product=Products(json['product']);
}
}

class Products {
   int? productId;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;

  Products(Map<String,dynamic>json){
productId=json['id'];
price=json['price'];
oldPrice=json['old_price'];
discount=json['discount'];
image=json['image'];
name=json['name'];
description=json['description'];
  }
}

// class FavoritesModel {
//   bool? status;
//   String? message;
//   Data? data;
//
//   FavoritesModel({this.status, this.message, this.data});
//
//   FavoritesModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     data = json['data'] != null ?  Data.fromJson(json['data']) : null;
//   }
// }

// class Data {
//   int? currentPage;
//   List<Data>? data;
//   String? firstPageUrl;
//   int? from;
//   int? lastPage;
//   String? lastPageUrl;
//   String? nextPageUrl;
//   String? path;
//   int? perPage;
//   String? prevPageUrl;
//   int? to;
//   int? total;
//
//   Data(
//       {this.currentPage,
//         this.data,
//         this.firstPageUrl,
//         this.from,
//         this.lastPage,
//         this.lastPageUrl,
//         this.nextPageUrl,
//         this.path,
//         this.perPage,
//         this.prevPageUrl,
//         this.to,
//         this.total});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     currentPage = json['current_page'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add( Data.fromJson(v));
//       });
//     }
//     firstPageUrl = json['first_page_url'];
//     from = json['from'];
//     lastPage = json['last_page'];
//     lastPageUrl = json['last_page_url'];
//     nextPageUrl = json['next_page_url'];
//     path = json['path'];
//     perPage = json['per_page'];
//     prevPageUrl = json['prev_page_url'];
//     to = json['to'];
//     total = json['total'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['current_page'] = this.currentPage;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     data['first_page_url'] = this.firstPageUrl;
//     data['from'] = this.from;
//     data['last_page'] = this.lastPage;
//     data['last_page_url'] = this.lastPageUrl;
//     data['next_page_url'] = this.nextPageUrl;
//     data['path'] = this.path;
//     data['per_page'] = this.perPage;
//     data['prev_page_url'] = this.prevPageUrl;
//     data['to'] = this.to;
//     data['total'] = this.total;
//     return data;
//   }
// }
//
// class Data {
//   int? id;
//   Product? product;
//
//   Data({this.id, this.product});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     product =
//     json['product'] != null ? new Product.fromJson(json['product']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     if (this.product != null) {
//       data['product'] = this.product!.toJson();
//     }
//     return data;
//   }
// }
//
// class Product {
//   int? id;
//   int? price;
//   int? oldPrice;
//   int? discount;
//   String? image;
//   String? name;
//   String? description;
//
//   Product(
//       {this.id,
//         this.price,
//         this.oldPrice,
//         this.discount,
//         this.image,
//         this.name,
//         this.description});
//
//   Product.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     price = json['price'];
//     oldPrice = json['old_price'];
//     discount = json['discount'];
//     image = json['image'];
//     name = json['name'];
//     description = json['description'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['price'] = this.price;
//     data['old_price'] = this.oldPrice;
//     data['discount'] = this.discount;
//     data['image'] = this.image;
//     data['name'] = this.name;
//     data['description'] = this.description;
//     return data;
//   }
// }