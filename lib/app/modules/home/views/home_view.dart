import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SIM Challenge'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Get.bottomSheet(
                _buildEditForm(controller),
                isScrollControlled: true,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Container(
          width: 343.w,
          height: 216.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            image: const DecorationImage(
              image: AssetImage('assets/images/bg_sim.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: Obx(() {
                  final name = controller.name.value;
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Opacity(
                      opacity: 0.2,
                      child: CustomPaint(painter: WatermarkPainter(name)),
                    ),
                  );
                }),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 36.h),
                  Row(
                    children: [
                      const Spacer(flex: 2),
                      Expanded(
                        flex: 7,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Obx(
                                () => Text(
                                  controller.simNumber.value,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    height: 1,
                                  ),
                                ),
                              ),
                              const Spacer(flex: 3),
                              Obx(
                                () => Text(
                                  controller.type.value,
                                  style: TextStyle(
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.bold,
                                    height: 1,
                                  ),
                                ),
                              ),
                              const Spacer(flex: 2),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Image.asset('assets/images/Photo.png', width: 70.w, height: 90.h),
                            12.verticalSpace,
                            Image.asset('assets/images/Sign.png', width: 70.w, height: 30.h),
                          ],
                        ),
                        10.horizontalSpace,
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Obx(() => _buildInfoRow('Nama/Name', controller.name.value)),
                                  const Spacer(flex: 8),
                                  const Icon(Icons.airport_shuttle),
                                  const Spacer(flex: 2),
                                ],
                              ),
                              Row(
                                children: [
                                  Obx(
                                    () => _buildInfoRow(
                                      'Tempat, Tgl Lahir/Place, Date of Birth',
                                      controller.birth.value,
                                    ),
                                  ),
                                  const Spacer(flex: 8),
                                  Text(
                                    'Mobil Penumpang Pribadi\nPassenger Car/Personal Goods',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 6.sp, fontWeight: FontWeight.bold),
                                  ),
                                  const Spacer(flex: 2),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Obx(
                                              () => _buildInfoRow(
                                                'Gol Darah/Blood Type',
                                                controller.bloodType.value,
                                              ),
                                            ),
                                            16.horizontalSpace,
                                            Obx(
                                              () => _buildInfoRow(
                                                'Jenis Kelamin/Gender',
                                                controller.gender.value,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Obx(
                                              () => _buildInfoRow(
                                                'Alamat/Address',
                                                controller.address.value,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Obx(
                                              () => _buildInfoRow(
                                                'Pekerjaan/Occupation',
                                                controller.occupation.value,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Obx(
                                              () => _buildInfoRow(
                                                'Diterbitkan Oleh/Issued By',
                                                controller.issuedBy.value,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Obx(
                                            () => QrImageView(
                                              data: controller.simNumber.value,
                                              version: QrVersions.auto,
                                              size: 64.w,
                                              backgroundColor: Colors.transparent,
                                              padding: EdgeInsets.zero,
                                            ),
                                          ),
                                          4.verticalSpace,
                                          Obx(
                                            () => Text(
                                              controller.expiredDate.value,
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WatermarkPainter extends CustomPainter {
  final String name;
  WatermarkPainter(this.name);

  @override
  void paint(Canvas canvas, Size size) {
    final textStyle = TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold);
    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    const step = 80.0;
    for (double y = -size.height; y < size.height * 2; y += step) {
      for (double x = -size.width; x < size.width * 2; x += step) {
        final textSpan = TextSpan(text: name, style: textStyle);
        textPainter.text = textSpan;
        textPainter.layout();

        canvas.save();
        canvas.translate(x, y);
        canvas.rotate(-0.5);
        textPainter.paint(canvas, Offset.zero);
        canvas.restore();
      }
    }
  }

  @override
  bool shouldRepaint(covariant WatermarkPainter oldDelegate) {
    return oldDelegate.name != name;
  }
}

Widget _buildInfoRow(String label, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(fontSize: 7.sp, fontWeight: FontWeight.bold),
      ),
      ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 180.w),
        child: Text(
          value,
          softWrap: true,
          maxLines: 2,
          overflow: TextOverflow.visible,
          style: TextStyle(fontSize: 9.sp, fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );
}

Widget _buildEditForm(HomeController controller) {
  final simCtrl = TextEditingController(text: controller.simNumber.value);
  final nameCtrl = TextEditingController(text: controller.name.value);
  final birthCtrl = TextEditingController(text: controller.birth.value);
  final addressCtrl = TextEditingController(text: controller.address.value);
  final typeCtrl = TextEditingController(text: controller.type.value);
  final bloodCtrl = TextEditingController(text: controller.bloodType.value);
  final genderCtrl = TextEditingController(text: controller.gender.value);
  final occupationCtrl = TextEditingController(text: controller.occupation.value);
  final issuedCtrl = TextEditingController(text: controller.issuedBy.value);
  final expiredCtrl = TextEditingController(text: controller.expiredDate.value);

  return Padding(
    padding: EdgeInsets.only(bottom: MediaQuery.of(Get.context!).viewInsets.bottom),
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Edit Data SIM', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          16.verticalSpace,
          _buildTextField('Nomor SIM', simCtrl),
          _buildTextField('Tipe SIM', typeCtrl),
          _buildTextField('Nama', nameCtrl),
          _buildTextField('Tempat, Tgl Lahir', birthCtrl),
          _buildTextField('Alamat', addressCtrl),
          _buildTextField('Gol Darah', bloodCtrl),
          _buildTextField('Jenis Kelamin', genderCtrl),
          _buildTextField('Pekerjaan', occupationCtrl),
          _buildTextField('Diterbitkan Oleh', issuedCtrl),
          _buildTextField('Tanggal Expired', expiredCtrl),
          20.verticalSpace,
          ElevatedButton(
            onPressed: () {
              controller.updateSIM(
                simNumber: simCtrl.text,
                type: typeCtrl.text,
                name: nameCtrl.text,
                birth: birthCtrl.text,
                address: addressCtrl.text,
                bloodType: bloodCtrl.text,
                gender: genderCtrl.text,
                occupation: occupationCtrl.text,
                issuedBy: issuedCtrl.text,
                expiredDate: expiredCtrl.text,
              );
              Get.back();
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    ),
  );
}

Widget _buildTextField(String label, TextEditingController ctrl) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: TextField(
      controller: ctrl,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
  );
}
