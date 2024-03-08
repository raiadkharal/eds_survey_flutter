import 'dart:io';

import 'package:flutter/material.dart';

class MerchandisingListItem extends StatelessWidget {
  final File? imageFile;
  final VoidCallback deleteCallback;

  const MerchandisingListItem({super.key, required this.imageFile, required this.deleteCallback});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Card(
          child: Stack(
            children: [
              Image.file(imageFile!,fit: BoxFit.fill,),
              Positioned(
                  top: -12,
                  right: -8,
                  child: IconButton(
                    color: Colors.grey,
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: deleteCallback,
                  ))
            ],
          ),
        ),
      );
  }
}
