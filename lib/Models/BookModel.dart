// ignore_for_file: prefer_const_constructors
import 'package:intl/intl.dart';
import 'package:test_project/Common/ModelIndex.dart';

class BookModel {

  int index = 0;
  String get author {
    return authors.reduce((value, element) {
      if (value == '') {
        return value;
      } else {
        return '$value, $element';
      }
    });
  }

  List<String> authors = [];
  String contents = "";
  String datetime = "";
  String isbn = "";

  String title = "";

  // var printContents: String {
  //
  // contents.replacingOccurrences(of: "", with: "\n□")
  // }

  String publisher = '';
  int price = 0;

  String get printMoneyPrice {

    return NumberFormat().moneyFormat(price);
  }

  int salePrice = 0;

  String get printMoneySalePrice {

    return NumberFormat().moneyFormat(salePrice);
  }

  String get printDate {
    final f = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZZZZ");
    var insertDate = f.parse(this.datetime);
    var outputDate = DateFormat("yyyy-MM-dd");

    return outputDate.format(insertDate);
  }

  String get printPrice {
    if (salePrice == -1) {
      return '가격 $price';
    } else {
      var tmpDate = DateTime.parse(this.datetime);

      return '할인가 : $printMoneySalePrice 정상가 : $printMoneyPrice';
    }
  }

  String status = "";
  String thumbnail = "";
  List<String> translators = [];

  String url = "";

  String get printTranslators {

    if(translators.isEmpty) {
      return '';
    } else {
      return translators.reduce((value, element) {
        if (value == '') {
          return value;
        } else {
          return '$value, $element';
        }
      });
    }
  }

  BookModel({
    required this.authors,
    required this.contents,
    required this.datetime,
    required this.isbn,
    required this.price,
    required this.publisher,
    required this.salePrice,
    required this.status,
    required this.thumbnail,
    required this.title,
    required this.translators,
    required this.url,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
        authors: List<String>.from(json["authors"].map((x) => x)),
        contents: json["contents"],
        datetime: json["datetime"],
        isbn: json["isbn"],
        price: json["price"],
        publisher: json["publisher"],
        salePrice: json["sale_price"],
        status: json["status"],
        thumbnail: json["thumbnail"],
        title: json["title"],
        translators: List<String>.from(json["translators"].map((x) => x)),
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "authors": List<dynamic>.from(authors.map((x) => x)),
        "contents": contents,
        "datetime": datetime,
        "isbn": isbn,
        "price": price,
        "publisher": publisher,
        "sale_price": salePrice,
        "status": status,
        "thumbnail": thumbnail,
        "title": title,
        "translators": List<dynamic>.from(translators.map((x) => x)),
        "url": url,
      };
}
