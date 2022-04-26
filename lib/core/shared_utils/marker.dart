import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future loadMarker(bool isIos, String path) async {
  try {
    var width = isIos ? 100 : 128;
    return await getBitmapDescriptorFromAssetBytes(path, width);
  } catch(e) {
    print("Error while fetching custom marker $e");
  }
}

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();

  var pngImage = await fi.image.toByteData(format: ui.ImageByteFormat.png);
  if (pngImage != null) {
    return pngImage.buffer.asUint8List();
  }

  // verify this!!
  return Uint8List.fromList([]);
}

Future<BitmapDescriptor> getBitmapDescriptorFromAssetBytes(String path, int width) async {
  final Uint8List imageData = await getBytesFromAsset(path, width);
  return BitmapDescriptor.fromBytes(imageData);
}