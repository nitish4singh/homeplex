import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';


class Utils {
  Size getScreenSize() {
    return MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
  }

  showSnackBar({required BuildContext context, required String content}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xff9b0b79),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 6),
        content: SizedBox(
          width: getScreenSize().width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                content,
                maxLines: 3,
                style: GoogleFonts.coda(
                  textStyle:
                      const TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Uint8List?> pickImage1() async {
    ImagePicker picker1 = ImagePicker();
    XFile? file1 = await picker1.pickImage(source: ImageSource.gallery,imageQuality:30);
    return file1!.readAsBytes();
  }

  Future<Uint8List?> pickImage2() async {
    ImagePicker picker2 = ImagePicker();
    XFile? file2 = await picker2.pickImage(source: ImageSource.gallery,imageQuality:30);
    return file2!.readAsBytes();
  }

  Future<Uint8List?> pickImage3() async {
    ImagePicker picker3 = ImagePicker();
    XFile? file3 = await picker3.pickImage(source: ImageSource.gallery,imageQuality:30);
    return file3!.readAsBytes();
  }

  Future<Uint8List?> pickImage4() async {
    ImagePicker picker4 = ImagePicker();
    XFile? file4 = await picker4.pickImage(source: ImageSource.gallery,imageQuality:30);
    return file4!.readAsBytes();
  }

 String  getUid() {
    return (Random().nextInt(5) * Random().nextInt(100) +
            Random().nextInt(10000))
        .toString();
  }
}
