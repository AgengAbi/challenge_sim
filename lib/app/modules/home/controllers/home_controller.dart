import 'package:get/get.dart';

class HomeController extends GetxController {
  var simNumber = '31750958011310001'.obs;
  var name = 'Putra Negara'.obs;
  var birth = 'Jakarta 17 AGUSTUS 1975'.obs;
  var address = 'MT HARYONO ST, RT.4/RW.2, CIKOKO, PANCORAN, JAKARTA SELATAN'.obs;
  var type = 'A'.obs;
  var bloodType = 'A'.obs;
  var gender = 'Pria'.obs;
  var occupation = 'POLRI'.obs;
  var issuedBy = 'METRO JAYA'.obs;
  var expiredDate = '21-12-2028'.obs;

  void updateSIM({
    String? simNumber,
    String? name,
    String? birth,
    String? address,
    String? type,
    String? bloodType,
    String? gender,
    String? occupation,
    String? issuedBy,
    String? expiredDate,
  }) {
    if (simNumber != null) this.simNumber.value = simNumber;
    if (name != null) this.name.value = name;
    if (birth != null) this.birth.value = birth;
    if (address != null) this.address.value = address;
    if (type != null) this.type.value = type;
    if (bloodType != null) this.bloodType.value = bloodType;
    if (gender != null) this.gender.value = gender;
    if (occupation != null) this.occupation.value = occupation;
    if (issuedBy != null) this.issuedBy.value = issuedBy;
    if (expiredDate != null) this.expiredDate.value = expiredDate;
  }
}
