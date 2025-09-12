import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class MediaPickerManager {
  final ImagePicker _picker;

  MediaPickerManager() : _picker = ImagePicker();

  Future<XFile?> pickImageFromGallery() async {
    try {
      return await _picker.pickImage(source: ImageSource.gallery);
    } catch (e) {
      rethrow;
    }
  }

  Future<XFile?> pickImageFromCamera(
      {CameraDevice? preferredCameraDevice}) async {
    try {
      return await _picker.pickImage(
          source: ImageSource.camera,
          preferredCameraDevice: preferredCameraDevice ?? CameraDevice.rear);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<XFile>> pickMultipleImagesFromGallery() async {
    try {
      return await _picker.pickMultiImage();
    } catch (e) {
      rethrow;
    }
  }

  Future<XFile?> pickVideoFromGallery() async {
    try {
      return await _picker.pickVideo(source: ImageSource.gallery);
    } catch (e) {
      rethrow;
    }
  }

  Future<XFile?> pickVideoFromCamera() async {
    try {
      return await _picker.pickVideo(source: ImageSource.camera);
    } catch (e) {
      rethrow;
    }
  }

  Future<XFile?> pickImageFromFiles() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'gif', 'heic'],
        allowMultiple: false,
      );
      if (result != null &&
          result.files.isNotEmpty &&
          result.files.first.path != null) {
        return XFile(result.files.first.path!);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<XFile>> pickMultipleImagesFromFiles() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'gif', 'heic'],
        allowMultiple: true,
      );
      if (result != null && result.files.isNotEmpty) {
        return result.files
            .where((file) => file.path != null)
            .map((file) => XFile(file.path!))
            .toList();
      }
      return <XFile>[];
    } catch (e) {
      rethrow;
    }
  }
}
