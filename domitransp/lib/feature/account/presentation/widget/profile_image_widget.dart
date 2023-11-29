import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProfileImageWidget extends StatefulWidget {
  String? image;

  ProfileImageWidget({super.key, required this.image});

  @override
  State<ProfileImageWidget> createState() => _ProfileImageWidgetState();
}

class _ProfileImageWidgetState extends State<ProfileImageWidget> {
  double imageSize = 75.0;

  @override
  Widget build(BuildContext context) {
    if (widget.image == null) {
      return noImage();
    } else {
      try {
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            widget.image!,
            width: imageSize,
            height: imageSize,
            errorBuilder: (BuildContext context, Object exception,
                StackTrace? stackTrace) {
              return noImage();
            },
          ),
        );
      } catch (e) {
        print('Falle en la imagen');
        return noImage();
      }
    }
  }

  Widget noImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(
        'assets/picture/imagen/imageProfile.png',
        width: imageSize,
        height: imageSize,
        fit: BoxFit.cover,
      ),
    );
  }
}
