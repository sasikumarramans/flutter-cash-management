import 'dart:async';
import 'dart:io';

import 'package:ev_flutter_app/app/helpers/app_file_manager.dart';
import 'package:ev_flutter_app/app/helpers/app_snack_bar_manager.dart';
import 'package:ev_flutter_app/app/theme/app_theme.dart';
import 'package:ev_flutter_app/presentation/component/outline_ripple_button.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image/image.dart' as img;

FutureOr<Uint8List> _cropImage(Map<String, dynamic> args) {
  final Uint8List bytes = args['bytes'] as Uint8List;
  final int left = args['left'] as int;
  final int top = args['top'] as int;
  final int width = args['width'] as int;
  final int height = args['height'] as int;
  final int rotate = args['rotate'] as int;
  final bool flipY = args['flipY'] as bool;
  img.Image? src = img.decodeImage(bytes);
  if (src == null) return Uint8List(0);
  img.Image edited = img.bakeOrientation(src);
  if (rotate != 0) {
    edited = img.copyRotate(edited, angle: rotate);
  }
  if (flipY) {
    edited = img.flip(edited, direction: img.FlipDirection.horizontal);
  }
  edited = img.copyCrop(
    edited,
    x: left,
    y: top,
    width: width,
    height: height,
  );
  return Uint8List.fromList(img.encodeJpg(edited));
}

class AppImageCropper extends StatefulWidget {
  final List<String> imagePaths;
  final List<String> savePaths;
  final double aspectRatio;
  final bool interactive;
  final Color maskColor;
  final Color baseColor;
  final String? title;
  final String? subTitle;
  final bool? isShowHandAnim;

  const AppImageCropper({
    super.key,
    required this.imagePaths,
    required this.savePaths,
    this.aspectRatio = 1.0,
    this.interactive = true,
    this.isShowHandAnim = false,
    this.maskColor = const Color(0x80000000),
    this.baseColor = Colors.black,
    this.title,
    this.subTitle,
  }) : assert(imagePaths.length == savePaths.length,
            'imagePaths and savePaths must have the same length');

  @override
  AppImageCropperState createState() => AppImageCropperState();
}

class AppImageCropperState extends State<AppImageCropper>
    with AutomaticKeepAliveClientMixin {
  late final List<GlobalKey<ExtendedImageEditorState>> _editorKeys;
  List<Uint8List> _images = [];
  final AppFileManager _fileManager = GetIt.I<AppFileManager>();
  int _selectedImageIndex = 0;
  bool _showHandAnimation = false;
  bool isCropping = false;

  @override
  void initState() {
    super.initState();
    _editorKeys = List.generate(
        widget.imagePaths.length, (_) => GlobalKey<ExtendedImageEditorState>());
    _loadImages();
    if (widget.isShowHandAnim!) {
      _showHandAnimationDelayed();
    }
  }

  void _showHandAnimationDelayed() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _showHandAnimation = true;
        });
      }
    });
  }

  Future<void> _loadImages() async {
    List<Uint8List> loaded = [];
    for (String path in widget.imagePaths) {
      final file = File(path);
      if (await file.exists()) {
        loaded.add(await file.readAsBytes());
      } else {
        print("File not found: $path");
      }
    }
    setState(() {
      _images = loaded;
    });
  }

  Future<void> _onCropAll() async {
    if (!_showHandAnimation) {
      isCropping = true;
      setState(() {});
    }
    GetIt.I<AppSnackBarManager>().showLoading();
    List<String> savedFilePaths = [];
    for (int i = 0; i < _editorKeys.length; i++) {
      final state = _editorKeys[i].currentState;
      if (state == null) continue;

      final Uint8List rawData = state.rawImageData;
      if (rawData.isEmpty) continue;
      final Rect? rect = state.getCropRect();
      Rect cropRect;
      if (rect == null || rect == Rect.zero) {
        final img.Image? srcImg = img.decodeImage(rawData);
        if (srcImg == null) continue;
        cropRect = Rect.fromLTWH(
          0,
          0,
          srcImg.width.toDouble(),
          srcImg.height.toDouble(),
        );
      } else {
        cropRect = rect;
      }

      final Map<String, dynamic> params = {
        'bytes': rawData,
        'left': cropRect.left.toInt(),
        'top': cropRect.top.toInt(),
        'width': cropRect.width.toInt(),
        'height': cropRect.height.toInt(),
        'rotate': state.editAction?.rotateDegrees.toInt() ?? 0,
        'flipY': state.editAction?.flipY ?? false,
      };
      final Uint8List editedBytes = await compute(_cropImage, params);
      if (editedBytes.isEmpty) continue;

      final Map<String, String> saveResult = await _fileManager.saveMedia(
        widget.savePaths[i],
        editedBytes,
        MediaExtension.jpg,
      );
      savedFilePaths.add(saveResult.values.first);
    }
    GetIt.I<AppSnackBarManager>().hideLoading();
    Navigator.pop(context, savedFilePaths);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (_images.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.title ?? "Adjust Image"),
        centerTitle: widget.isShowHandAnim! ? true : false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Text(
                widget.subTitle ?? "Fit the subject within\nthis frame",
                style: AppTheme.promptHintTextStyle.copyWith(
                  fontStyle: FontStyle.italic,
                  fontSize: 17,
                  color: AppTheme.tertiaryTextColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Expanded(
                child: IndexedStack(
                  index: _selectedImageIndex,
                  children: List.generate(_images.length, (index) {
                    return CropPage(
                      key: PageStorageKey('cropPage_$index'),
                      imageData: _images[index],
                      editorKey: _editorKeys[index],
                      aspectRatio: widget.aspectRatio,
                    );
                  }),
                ),
              ),
              IconButton(
                onPressed: () {
                  final editorState =
                      _editorKeys[_selectedImageIndex].currentState;
                  if (editorState != null) {
                    editorState.rotate(
                      degree: -90,
                      rotateCropRect: false,
                    );
                  }
                },
                icon: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Icon(Icons.add),
                ),
              ),
              SizedBox(
                height: 80,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: _images.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedImageIndex = index;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Image.memory(
                          _images[index],
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              Container(
                color: const Color(0xff2C2C2E),
                child: SafeArea(
                  minimum: const EdgeInsets.only(
                    left: 20,
                    bottom: 20,
                    right: 20,
                    top: 10,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => Navigator.pop(context),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 21),
                          child: Text("Back",
                              style: AppTheme.simpleWhiteTextStyle),
                        ),
                      ),
                      const Spacer(),
                      if (!_showHandAnimation)
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () async {
                            await () async {
                              await Future.microtask(() => _onCropAll());
                            }();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 21),
                            child: Text("Next",
                                style: AppTheme.simpleWhiteTextStyle),
                          ),
                        ),
                      if (_showHandAnimation && !isCropping)
                        InkWell(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              const OutlineRippleButton(),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 21),
                                child: Text("Next",
                                    style: AppTheme.simpleWhiteTextStyle),
                              )
                            ],
                          ),
                          onTap: () async {
                            await () async {
                              await Future.microtask(() => _onCropAll());
                            }();
                          },
                        ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class CropPage extends StatefulWidget {
  final Uint8List imageData;
  final GlobalKey<ExtendedImageEditorState> editorKey;
  final double aspectRatio;

  const CropPage({
    super.key,
    required this.imageData,
    required this.editorKey,
    required this.aspectRatio,
  });

  @override
  _CropPageState createState() => _CropPageState();
}

class _CropPageState extends State<CropPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ExtendedImage.memory(
      widget.imageData,
      fit: BoxFit.contain,
      mode: ExtendedImageMode.editor,
      cacheRawData: true,
      extendedImageEditorKey: widget.editorKey,
      initEditorConfigHandler: (state) {
        return EditorConfig(
          cropAspectRatio: widget.aspectRatio,
          initCropRectType: InitCropRectType.imageRect,
          cornerColor: Colors.white,
          lineHeight: 0.1,
          cropRectPadding: const EdgeInsets.all(8),
        );
      },
    );
  }
}
