import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter_doc_scanner/flutter_doc_scanner.dart';

class DocumentScannerService {
  final FlutterDocScanner _docScanner = FlutterDocScanner();


  Future<List<String>?> scanDocumentsAsImages({int page = 4}) async {
    try {
      final dynamic result = await _docScanner.getScannedDocumentAsImages(page: page);
      debugPrint("result scanDocument : $result");
      if (result is ImageScanResult) {
        final imagesList = result.images; // already List<String>
        debugPrint('imageList : $imagesList');

        // Clean every path in the list
        return imagesList.map((path) => _cleanPath(path)).toList();
      }
      else if (result is Map && result.containsKey('images')) {
        final List<dynamic> imagesList = result['images'];

        // Clean every path in the list
        debugPrint('imageList : $imagesList');
        return imagesList.map((path) => _cleanPath(path.toString())).toList();
      } else if (result is List && result.isNotEmpty) {
        return List<String>.from(result.map((r) => r.toString()));
      }
      return null;
    } catch (e) {
      throw DocumentScannerServiceException('Failed to scan documents: ${e.toString()}');
    }
  }

  Future<String?> scanDocumentsAsPdf({required int page}) async {
    try {
      final dynamic result = await _docScanner.getScannedDocumentAsPdf(page: page);
      debugPrint('Pdf Results : $result');

      if (result is Map && result.containsKey('pdfUri')) {
        final String  pdfString = result['pdfUri'];

        return _cleanPath(pdfString);
      }
      return null;
    } catch (e) {
      debugPrint('PDF error: $e');
      throw DocumentScannerServiceException('Failed to scan documents: ${e.toString()}');
    }
  }

  /// Private helper to convert URI (file:///) to a System Path
  String _cleanPath(String rawPath) {
    try {
      // This turns "file:///path/to/image.jpg" into "/path/to/image.jpg"
      return Uri.parse(rawPath).toFilePath();
    } catch (e) {
      return rawPath;
    }
  }

  /// Validate if the scanned file exists
  Future<bool> validateScannedFile(String path) async {
    try {
      debugPrint("path : $path");
      final file = File(path);
      return await file.exists();
    } catch (e) {
      return false;
    }
  }

  /// Get file size in bytes
  Future<int> getFileSize(String path) async {
    try {
      final file = File(path);
      return await file.length();
    } catch (e) {
      throw DocumentScannerServiceException(
        'Failed to get file size: ${e.toString()}',
      );
    }
  }

  // String path to uint8list
  Future<Uint8List> pathToUint8List(String path) async {
    try {
      final file = File(path);
      return await file.readAsBytes();
    } catch (e) {
      return Uint8List(0);
    }
  }

}

/// Custom exception for scanner service errors
class DocumentScannerServiceException implements Exception {
  final String message;

  DocumentScannerServiceException(this.message);

  @override
  String toString() => message;
}
