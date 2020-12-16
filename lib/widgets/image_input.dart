import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ImageInput extends StatefulWidget {
  final Function onSelectedImage;
  ImageInput(this.onSelectedImage);
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  _takePicture() async {
    final ImagePicker _picker = ImagePicker();
    PickedFile _imageFile = await _picker.getImage(
      source: ImageSource.camera,
      maxHeight: 600,
    );

    if (_imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = File(_imageFile.path);
    });

    final appDir = await getApplicationDocumentsDirectory();
    String fileName = basename(_storedImage.path);
    final savedImage = await _storedImage.copy('${appDir.path}/$fileName');

    widget.onSelectedImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 180,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          alignment: Alignment.center,
          child: _storedImage != null
              ? Image.file(
                  _storedImage,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              : Text('No Image'),
        ),
        SizedBox(width: 10),
        Expanded(
          child: FlatButton.icon(
            icon: Icon(Icons.camera),
            textColor: Theme.of(context).primaryColor,
            label: Text('Capture'),
            onPressed: _takePicture,
          ),
        )
      ],
    );
  }
}
