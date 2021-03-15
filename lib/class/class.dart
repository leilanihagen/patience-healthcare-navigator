class Insurances {
  final String name;
  final List<String> plans;
  Insurances(this.name, this.plans);
}

class Search {
  final String name;
  final int lowerCpt, upperCpt;
  Search(this.name, this.lowerCpt, this.upperCpt);
  Search.fromString(List<dynamic> item) : this(item[0], item[1], item[2]);
}

class ProceduresController {
  List<Procedure> procedures = [];
  String provider, state, stateCode;
  int totalLowerPrice, totalUpperPrice, numSection, numGroup;
  ProceduresController();
  void add(Procedure p) {
    // if (procedures.contains(p)) if (this.procedures.firstWhere(
    //         (element) => (element.name == p.name),
    //         orElse: () => null) ==
    //     null)
    this.procedures.insert(0, p);
  }

  bool checkExist(Search s) {
    for (Procedure p in this.procedures) if (p.name == s.name) return true;
    return false;
  }

  update() {
    var low = 0, upper = 0;
    var numSec = Set();
    var numG = Set();
    procedures.forEach((element) {
      low += element.lowerPrice;
      upper += element.upperPrice;
      numSec.add(element.section);
      numG.add(element.group);
    });
    totalLowerPrice = low;
    totalUpperPrice = upper;
    numSection = numSec.length;
    numGroup = numG.length;
  }

  Map toJson() {
    List<Map> p = this.procedures != null
        ? this.procedures.map((e) => e.toJson()).toList()
        : null;
    return {
      'provider': provider,
      'state': state,
      'stateCode': stateCode,
      'totalLowerPrice': totalLowerPrice,
      'totalUpperPrice': totalUpperPrice,
      'numSection': numSection,
      'numGroup': numGroup,
      'procedures': p
    };
  }

  ProceduresController.fromJson(Map<String, dynamic> json) {
    provider = json['provider'];
    state = json['state'];
    stateCode = json['stateCode'];
    totalLowerPrice = json['totalLowerPrice'];
    totalUpperPrice = json['totalUpperPrice'];
    numSection = json['numSection'];
    numGroup = json['numGroup'];
    Iterable tmp = json['procedures'];
    procedures = List<Procedure>.from(tmp.map((e) => Procedure.fromJson(e)));
  }
}

class Procedure {
  final String name, codeUrl, priceUrl, section, group;
  final int lowerCpt, upperCpt, lowerPrice, upperPrice;

  // Procedure.fromSearch(Search search)
  //     : name = search.name,
  //       lowerCpt = search.lowerCpt,
  //       upperCpt = search.upperCpt;
  Procedure.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        lowerCpt = json['lower_cpt'],
        upperCpt = json['upper_cpt'],
        lowerPrice = json['lower_price'],
        upperPrice = json['upper_price'],
        codeUrl = json['code_url'],
        priceUrl = json['price_url'],
        section = json['section'],
        group = json['group'];
  // updateFromJson(Map<String, dynamic> json) {
  //   this.lowerPrice = json['lower_price'];
  //   this.upperPrice = json['upper_price'];
  //   this.codeUrl = json['code_url'];
  //   this.priceUrl = json['price_url'];
  //   this.section = json['section'];
  //   this.group = json['group'];
  // }

  Map toJson() => {
        'name': name,
        'lower_cpt': lowerCpt,
        'upper_cpt': upperCpt,
        'section': section,
        'group': group,
        'code_url': codeUrl,
        'price_url': priceUrl,
        'lower_price': lowerPrice,
        'upper_price': upperPrice
      };
  String lowerCurrency() {
    return """\$ ${this.lowerPrice.toString()}""";
  }

  String upperCurrency() {
    return """\$ ${this.upperPrice.toString()}""";
  }
}

class Top3 {
  String name;
  double distance;
  Top3(this.name, this.distance);
  Top3.fromJson(Map<String, dynamic> json)
      : distance = json['distance'],
        name = json['name'];
  Map toJson() => {'name': name, 'distance': distance};
}

class HospitalPage {
  int check;
  String name, address, status;
  List<Top3> top3;
  HospitalPage() {
    this.name = "";
    this.address = "";
    this.status = "";
    check = 0;
  }
  HospitalPage.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address = json['address'];
    status = json['status'];
    check = json['check'];
    Iterable tmp = json['top3'];
    top3 = List<Top3>.from(tmp.map((e) => Top3.fromJson(e)));
  }
  Map toJson() {
    List<Map> t3 =
        this.top3 != null ? this.top3.map((e) => e.toJson()).toList() : null;
    return {
      'name': name,
      'address': address,
      'status': status,
      'check': check,
      'top3': t3
    };
  }
}
