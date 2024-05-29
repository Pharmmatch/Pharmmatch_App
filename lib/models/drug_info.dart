class DrugInfo {
  String? drugName;
  String? entName;
  String? code;
  String? codeATC;
  String? dose;
  String? efcy;
  String? useMethod;
  String? se;

  DrugInfo({
    this.drugName,
    this.entName,
    this.code,
    this.codeATC,
    this.dose,
    this.efcy,
    this.useMethod,
    this.se,
  });

  factory DrugInfo.fromJson(Map<String, dynamic> json) {
    return DrugInfo(
      drugName: json['itemName'],
      entName: json['entpName'],
      code: json['itemSeq'],
      efcy: json['efcyQesitm'],
      useMethod: json['useMethodQesitm'],
      se: json['seQesitm'] ?? '', // null 값이 들어오면 기본값 empty string으로
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['drugName'] = drugName;
    data['entName'] = entName;
    data['code'] = code;
    data['codeATC'] = codeATC;
    data['dose'] = dose;
    data['efcy'] = efcy;
    data['useMethod'] = useMethod;
    data['se'] = se;

    return data;
  }
}
