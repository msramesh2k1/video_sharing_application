library video_thumbnail_generator;

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ThumbnailImage extends StatelessWidget {
  final String videoUrl;
  final double? width;

  final double? height;

  final double scale;
  final ImageFrameBuilder? frameBuilder;

  ///
  final ImageErrorWidgetBuilder? errorBuilder;

  final String? semanticLabel;

  final bool excludeFromSemantics;

  final Color? color;

  final BlendMode? colorBlendMode;

  final BoxFit? fit;

  final AlignmentGeometry alignment;

  /// How to paint any portions of the layout bounds not covered by the image.
  final ImageRepeat repeat;

  final Rect? centerSlice;

  /// Whether to paint the image in the direction of the [TextDirection].
  ///
  /// If this is true, then in [TextDirection.ltr] contexts, the image will be
  /// drawn with its origin in the top left (the "normal" painting direction for

  final bool matchTextDirection;

  final bool gaplessPlayback;

  final bool isAntiAlias;

  final FilterQuality filterQuality;
  final int? cacheWidth;
  final int? cacheHeight;

  ThumbnailImage({
    required this.videoUrl,
    this.width,
    this.height,
    this.scale: 1.0,
    this.frameBuilder,
    this.errorBuilder,
    this.semanticLabel,
    this.excludeFromSemantics: false,
    this.color,
    this.colorBlendMode,
    this.fit,
    this.alignment: Alignment.center,
    this.repeat: ImageRepeat.noRepeat,
    this.centerSlice,
    this.matchTextDirection: false,
    this.gaplessPlayback: false,
    this.isAntiAlias: false,
    this.filterQuality: FilterQuality.low,
    this.cacheHeight,
    this.cacheWidth,
  }) : assert(videoUrl != null);

  Future<String> getThumbnailFromVideo() async {
    String input = '{"videoUrl" : "$videoUrl"}';
    String url =
        "https://video-thumbnail-generator-pub.herokuapp.com/generate/thumbnail";
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {"Content-type": "application/json"},
        body: input,
      );
      if (response.statusCode == 200) {
        var data = response.body;
        return data;
      } else {
        throw 'Could not fetch data from api | Error Code: ${response.statusCode}';
      }
    } on Exception catch (e) {
      throw "Error : $e";
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getThumbnailFromVideo(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        print(snapshot.connectionState);
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.data == null) {
              return Image.network(
                "http://no_image",
                width: width,
                height: height,
                scale: scale,
                frameBuilder: frameBuilder,
                errorBuilder: errorBuilder,
                semanticLabel: semanticLabel,
                excludeFromSemantics: excludeFromSemantics,
                color: color,
                colorBlendMode: colorBlendMode,
                fit: fit,
                alignment: alignment,
                repeat: repeat,
                centerSlice: centerSlice,
                matchTextDirection: matchTextDirection,
                gaplessPlayback: gaplessPlayback,
                isAntiAlias: isAntiAlias,
                filterQuality: filterQuality,
                cacheHeight: cacheHeight,
                cacheWidth: cacheWidth,
              );
            }
            return Image.memory(
              base64Decode(snapshot.data),
              width: width,
              height: height,
              scale: scale,
              frameBuilder: frameBuilder,
              errorBuilder: errorBuilder,
              semanticLabel: semanticLabel,
              excludeFromSemantics: excludeFromSemantics,
              color: color,
              colorBlendMode: colorBlendMode,
              fit: fit,
              alignment: alignment,
              repeat: repeat,
              centerSlice: centerSlice,
              matchTextDirection: matchTextDirection,
              gaplessPlayback: gaplessPlayback,
              isAntiAlias: isAntiAlias,
              filterQuality: filterQuality,
              cacheHeight: cacheHeight,
              cacheWidth: cacheWidth,
            );
        }
        return Container();
      },
    );
  }
}

class VideoThumbnail {
  static Future<Uint8List> getBytes(String videoUrl) async {
    String input = '{"videoUrl" : "$videoUrl"}';
    String url =
        "https://video-thumbnail-generator-pub.herokuapp.com/generate/thumbnail";
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {"Content-type": "application/json"},
        body: input,
      );
      if (response.statusCode == 200) {
        var data = response.body;
        return base64Decode(data);
      } else {
        throw 'Could not fetch data from api | Error Code: ${response.statusCode}';
      }
    } on Exception catch (e) {
      throw "Error : $e";
    }
  }
}
