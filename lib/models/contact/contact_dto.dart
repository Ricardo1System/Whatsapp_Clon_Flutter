class ContactDto {
  final String? image;
  final String name;
  final String? msj;
  final String? time;
  final bool isCompany;
  final bool isIa;

  ContactDto({this.isCompany=false,
    this.image,
    this.isIa=false,
    required this.name,
    this.msj,
    this.time,
  });
}