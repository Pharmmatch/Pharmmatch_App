class USDrug {
  String? name;
  int? sim;

  USDrug({
    this.name,
    this.sim,
  });

  factory USDrug.fromJson(Map<String, dynamic> json) {
    return USDrug(
      name: json['name'] ?? 0,
      sim: (100 * json['similarity']).round(),
    );
  }
}
