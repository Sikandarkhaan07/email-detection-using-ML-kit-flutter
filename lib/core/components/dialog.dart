import 'package:flutter/material.dart';

class DialogUtility {
  static void showBottomSheet(
      {required BuildContext context,
      required Function fromCamera,
      required Function fromGallery}) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (_) {
        return ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 10, bottom: 27),
          children: [
            const Text(
              'Pick Profile Image',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: const CircleBorder(),
                    fixedSize: const Size(100, 100),
                  ),
                  onPressed: () {
                    fromGallery();
                  },
                  child: Image.asset('assets/images/picture.png'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: const CircleBorder(),
                    fixedSize: const Size(100, 100),
                  ),
                  onPressed: () {
                    fromCamera();
                  },
                  child: Image.asset('assets/images/camera.png'),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  static void showProgressBar(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
  }
}
