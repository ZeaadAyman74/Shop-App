class HomeModel {
  bool? status;
   DataModel? data; // banners[],product[],ad str
  HomeModel(Map<String, dynamic>json) {
    status = json['status'];
    data = DataModel(json['data']);
  }
}

class DataModel {
  String? ad;
  List<BannerModel> banners=[];
  List<ProductModel> products=[];

  DataModel(Map<String, dynamic>data) {
    ad = data['ad'];
 data['banners'].forEach((element){
   banners.add(BannerModel((element)));
 });
    data['products'].forEach((element){
      products.add(ProductModel(element));
    });
  }

}

class BannerModel {
  int? id;
  String? image;
  BannerModel(Map<String, dynamic>banner) {
    id = banner['id'];
    image = banner['image'];
  }
}

class ProductModel {
 late int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;
  List? images;
   late bool inFavorites;
  bool? inCart;

  ProductModel(Map<String, dynamic>product) {
        id =product['id'];
        price =product['price'];
        oldPrice =product['old_price'];
        discount =product['discount'];
        image =product['image'];
        name =product['name'];
        inFavorites =product['in_favorites'];
        inCart =product['inCart'];
  }
}