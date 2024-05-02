import 'dart:io';

import 'package:eds_survey/data/models/MerchandisingImage.dart';
import 'package:flutter/material.dart';

class MerchandisingListItem extends StatelessWidget {
  final MerchandisingImage merchandiseImage;
  final VoidCallback deleteCallback;

  const MerchandisingListItem(
      {super.key,
      required this.merchandiseImage,
      required this.deleteCallback});

  @override
  Widget build(BuildContext context) {
    File imageFile = File(merchandiseImage.path ?? "");
    return SizedBox(
      child: Card(
        child: Stack(
          children: [
            Image.file(
              imageFile,
              fit: BoxFit.fill,
            ),
            Positioned(
                top: -15,
                right: -15,
                child: IconButton(
                  color: Colors.grey,
                  icon: const Icon(Icons.close, color: Colors.white,size: 15,),
                  onPressed: deleteCallback,
                ))
          ],
        ),
      ),
    );
  }
}
