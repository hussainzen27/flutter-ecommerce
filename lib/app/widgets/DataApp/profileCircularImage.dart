import 'package:flutter/material.dart';

class ProfileCircularImage extends StatelessWidget {
  const ProfileCircularImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        height: 200.0,
        top: 150.0,
        left: 100.0,
        right: 100.0,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.0),
                  border: Border.all(color: Colors.white, width: 15.0)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: Image.asset(
                  'lib/app/assets/profileImage.png',
                  fit: BoxFit.cover,
                  height: 150.0,
                  width: 150.0,
                  scale: 100.0,
                ),
              ),
            ),
            Positioned(
                bottom: 10.0,
                right: 40.0,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: Container(
                      color: const Color.fromRGBO(232, 143, 185, 1),
                      padding: const EdgeInsets.all(10.0),
                      child: const Icon(
                        Icons.edit,
                        size: 24.0,
                        color: Colors.white,
                      ),
                    ))),
          ],
        ));
  }
}
