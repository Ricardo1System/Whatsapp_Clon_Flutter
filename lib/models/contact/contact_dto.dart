

class ContactDto {

  final String name;
  final String number;
  final String info;
  final String imageProfile;

  ContactDto({required this.name, required this.number, required this.info, required this.imageProfile});

  factory ContactDto.fromJson (Map<String, dynamic> json) {

    return ContactDto(
      name: json["Name"],
      number: json["Number"] ?? '',
      info: json["Info"] ?? '',
      imageProfile: json["ImageProfile"] ?? '',
    );
  }
  
}