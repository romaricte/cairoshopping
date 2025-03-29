import 'package:shopping/constants/color_data.dart';
import 'package:shopping/models/model_banner.dart';
import 'package:shopping/models/model_cart.dart';
import 'package:shopping/models/model_category.dart';
import 'package:shopping/models/model_intro.dart';
import 'package:shopping/models/model_my_order.dart';
import 'package:shopping/models/model_trending.dart';

import '../models/address_model.dart';
import '../models/model_category_items.dart';
import '../models/payment_card_model.dart';
import '../models/product_model.dart';

class DataFile {
  static List<ModelBanner> getAllBanner() {
    List<ModelBanner> introList = [];

    introList
        .add(ModelBanner(1, "Best Fashion\nCollection", "20%", "banner.png"));
    introList
        .add(ModelBanner(2, "Best Fashion\nCollection", "20%", "banner.png"));
    introList
        .add(ModelBanner(2, "Best Fashion\nCollection", "20%", "banner.png"));

    return introList;
  }

  static List<ProductModel> getCartModel() {
    List<ProductModel> subList = [];

    ProductModel model = ProductModel();
    model.name = "Kid's Girl Shrug";
    model.subTitle = "Stylish Girl";
    model.image = "order1.png";
    model.address = "Sean casey(4 km)";
    model.price = "\$22.00";
    model.offerPrice = "\$10";
    model.desc = "Female, 1.5 Years";
    subList.add(model);

    model = ProductModel();
    model.name = "Women's Crop Skirt";
    model.subTitle = "Trendy";
    model.address = "North Shore(2 km)";
    model.image = "order2.png";
    model.price = "\$18.00";
    model.offerPrice = "\$10";
    model.desc = "Male, 1 Years";
    subList.add(model);

    model = ProductModel();
    model.name = "Kid's Boy Cloths";
    model.subTitle = "Stylish Kids";
    model.image = "order3.png";
    model.price = "\$14.00";
    model.address = "Sean casey(4 km)";
    model.offerPrice = "\$25";
    model.desc = "Female, 2 Years";
    subList.add(model);

    return subList;
  }

  static List<ModelMyOrder> getMyOrders() {
    List<ModelMyOrder> subList = [];

    ModelMyOrder model = ModelMyOrder();
    model.name = "Kid's Girl Shrug";
    model.subTitle = "Stylish Girl";
    model.image = "order1.png";
    model.address = "Sean casey(4 km)";
    model.price = "\$22.00";
    model.offerPrice = "\$10";
    model.desc = "Female, 1.5 Years";
    model.status = "Pending";
    model.color = "#E09F2D".toColor();

    subList.add(model);

    model = ModelMyOrder();
    model.name = "Women's Crop Skirt";
    model.subTitle = "Trendy";
    model.address = "North Shore(2 km)";
    model.image = "order2.png";
    model.price = "\$18.00";
    model.offerPrice = "\$10";
    model.desc = "Male, 1 Years";
    model.status = "Delivered";
    model.color = "#29BA4A".toColor();

    subList.add(model);

    model = ModelMyOrder();
    model.name = "Kid's Boy Cloths";
    model.subTitle = "Stylish Kids";
    model.image = "order3.png";
    model.price = "\$14.00";
    model.address = "Sean casey(4 km)";
    model.offerPrice = "\$25";
    model.desc = "Female, 2 Years";
    model.status = "Cancelled";
    model.color = "#FB192D".toColor();

    subList.add(model);

    return subList;
  }

  static List<PaymentCardModel> getPaymentCardList() {
    List<PaymentCardModel> subCatList = [];

    PaymentCardModel mainModel = PaymentCardModel();
    mainModel.id = 1;
    mainModel.name = "Paypal";
    mainModel.image = "paypal.svg";
    mainModel.desc = "5416";
    subCatList.add(mainModel);

    mainModel = PaymentCardModel();
    mainModel.id = 2;
    mainModel.name = "Master Card";
    mainModel.desc = "8624";
    mainModel.image = "mastercard.svg";
    subCatList.add(mainModel);

    return subCatList;
  }

  static List<AddressModel> getAddressList() {
    List<AddressModel> subCatList = [];

    AddressModel mainModel = AddressModel();
    mainModel.id = 1;
    mainModel.name = "Chloe B Bird";
    mainModel.phoneNumber = "+1(368)68 000 068";
    mainModel.location = "87  Great North Road,ALTON,Great North Road";
    mainModel.type = "Home";
    subCatList.add(mainModel);

    mainModel = AddressModel();
    mainModel.id = 2;
    mainModel.name = "Rich P. Jeffery";
    mainModel.phoneNumber = "+1(368)68 000 068";
    mainModel.location =
        "4310 Clover Drive Colorado Springs,Clover Drive Colorado Springs, CO 80903";
    mainModel.type = "Company";
    subCatList.add(mainModel);

    return subCatList;
  }

  static List<ModelCategory> getAllCategory() {
    List<ModelCategory> introList = [];

    introList.add(ModelCategory(1, "Men", "cat_1.png"));
    introList.add(ModelCategory(2, "Women", "cat_2.png"));
    introList.add(ModelCategory(3, "Kids", "cat_3.png"));
    introList.add(ModelCategory(4, "Cookware", "cat_4.png"));
    introList.add(ModelCategory(5, "Electronic", "cat_5.png"));
    introList.add(ModelCategory(6, "Furniture", "cat_6.png"));

    return introList;
  }

  static List<ModelCategoryItems> getAllCategoryItems() {
    List<ModelCategoryItems> introList = [];

    introList.add(ModelCategoryItems(1, "Jackets", "item_1.png", "800"));
    introList.add(ModelCategoryItems(2, "Pants", "item_2.png", "520"));
    introList.add(ModelCategoryItems(3, "Shirts", "item_3.png", "1200"));
    introList.add(ModelCategoryItems(4, "Belts", "item_4.png", "1400"));
    introList.add(ModelCategoryItems(5, "Shoes", "item_5.png", "325"));
    introList.add(ModelCategoryItems(6, "Wallets", "item_6.png", "752"));

    return introList;
  }

  static List<ModelTrending> getAllTrendingProduct() {
    List<ModelTrending> introList = [];

    introList
        .add(ModelTrending(1, "Kid's Girl Shrug", "trend_1.png", "\$12.00"));
    introList
        .add(ModelTrending(2, "Women's Crop Dress", "trend_2.png", "\$16.00"));

    return introList;
  }

  static List<String> sizeList = ["S", "M", "L", "XL", "XXL"];
  static List<String> colorList = [
    "color1.png",
    "color2.png",
    "color3.png",
    "color4.png",
    "color5.png",
  ];

  // static List<Color> colorList = [
  //   "#3E682C".toColor(),
  //   "#9EC1E2".toColor(),
  //   "#EACF81".toColor(),
  //   "#AE95CF".toColor(),
  //   "#E99B7D".toColor()
  // ];

  static List<ModelCart> getAllCartList() {
    List<ModelCart> cartList = [];

    cartList.add(ModelCart(
        1, "Kid's Girl Shrug", "Stylish Girl", "order1.png", "\$18.00", "1"));
    cartList.add(ModelCart(
        2, "Women's Crop Skirt", "Trendy", "order2.png", "\$20.00", "2"));
    cartList.add(ModelCart(
        3, "Kid's Boy Cloths", "Stylish Kids", "order3.png", "\$14.00", "1"));

    return cartList;
  }

  static List<ModelTrending> getAllPopularProduct() {
    List<ModelTrending> introList = [];

    introList
        .add(ModelTrending(1, "Women's Crop Skirt", "order2.png", "\$18.00"));
    introList.add(ModelTrending(2, "Men's Shirt", "order4.png", "\$16.00",
        sale: "\$20.00"));
    introList.add(ModelTrending(3, "Kid's Girl Shrug", "order1.png", "\$12.00",
        sale: "\$26.00"));
    introList
        .add(ModelTrending(4, "Kid's Boy Cloths", "order3.png", "\$14.00"));
    introList.add(
        ModelTrending(5, "Women's Casual Outfit", "order2.png", "\$24.00"));
    introList
        .add(ModelTrending(6, "Kid's Boy T-shirt", "order4.png", "\$29.00"));

    return introList;
  }

  static List<ModelIntro> getAllIntroData() {
    List<ModelIntro> introList = [];
    introList.add(ModelIntro(
        1,
        "Shop Best Collection\n For Your Style",
        "Make your lifestyle stylish and feel happier with our\n latest fashion products.",
        "intro1.png"));

    introList.add(ModelIntro(
        2,
        "Trending Items For\n Men's Style",
        "Make your lifestyle stylish and feel happier with our\n latest fashion products.",
        "intro2.png"));

    introList.add(ModelIntro(
        3,
        "Shop Our Stylish\n Fashion Items",
        "Make your lifestyle stylish and feel happier with our\n latest fashion products.",
        "intro3.png"));

    introList.add(ModelIntro(
        4,
        "Welcome to Shopping",
        "Make your lifestyle stylish and feel happier with our\n latest fashion products.",
        "intro4.png"));

    return introList;
  }
}
