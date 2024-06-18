class DrugInfo {
  int? drugID;
  String? drugName;
  String? entName;
  String? efcy;
  String? imgUrl;
  String? codeATC;
  String? ingrString;

  DrugInfo({
    this.drugID,
    this.drugName,
    this.entName,
    this.efcy,
    this.imgUrl,
    this.codeATC,
    this.ingrString,
  });

  factory DrugInfo.fromJson(Map<String, dynamic> json) {
    return DrugInfo(
      drugID: json['id'],
      drugName: json['drug_name'],
      entName: json['ent_name'],
      efcy: json['efcy'],
      imgUrl: json['img_url'],
      codeATC: json['atc_code'],
      ingrString: json['ingr_string'], // ?? '' null 값이 들어오면 기본값 empty string으로
    );
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['drugName'] = drugName;
  //   data['entName'] = entName;
  //   data['code'] = code;
  //   data['codeATC'] = codeATC;
  //   data['dose'] = dose;
  //   data['efcy'] = efcy;
  //   data['useMethod'] = useMethod;
  //   data['se'] = se;

  //   return data;
  // }
}
