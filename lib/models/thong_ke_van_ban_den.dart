class ThongKeVanBanDenResult {
  ThongKeVanBanDenResult({
    required this.maLoai,
    required this.tieuDe,
    required this.conHan,
    required this.quaHan,
  });
  late final String maLoai;
  late final String tieuDe;
  late final int conHan;
  late final int quaHan;

  ThongKeVanBanDenResult.fromJson(Map<String, dynamic> json){
    maLoai = json['maLoai'];
    tieuDe = json['tieuDe'];
    conHan = json['conHan'];
    quaHan = json['quaHan'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['maLoai'] = maLoai;
    _data['tieuDe'] = tieuDe;
    _data['conHan'] = conHan;
    _data['quaHan'] = quaHan;
    return _data;
  }
}