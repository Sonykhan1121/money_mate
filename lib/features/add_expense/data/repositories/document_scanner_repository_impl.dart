import '../models/result.dart';
import '../../../../core/errors/scan_failure.dart';
import '../services/document_scanner_service.dart';
import '../../domain/repositories/document_scanner_repository.dart';


class DocumentScannerRepositoryImpl implements DocumentScannerRepository {
  final DocumentScannerService _scannerService;

  DocumentScannerRepositoryImpl({
    required DocumentScannerService scannerService,
  })  : _scannerService = scannerService;

  @override
  Future<Result<List<String>, ScanFailure>> scanDocumentAsImages({int page = 4}) async {
    try {
      // 1. Get the list of cleaned paths from the service
      List<String>? scannedPaths = await _scannerService.scanDocumentsAsImages(page: page);

      print('ScannedPaths scanDocumentAsImages: $scannedPaths');

      // 2. Handle null (user cancelled) or empty results
      if (scannedPaths == null || scannedPaths.isEmpty) {
        scannedPaths = [];
        return Success(scannedPaths);
      }

      // 3. Validate ALL scanned files in the list
      // We use Future.wait to check all files in parallel for better performance
      final validationResults =
          await Future.wait(scannedPaths.map((path) => _scannerService.validateScannedFile(path)));

      // If any file in the list is invalid, return a failure
      if (validationResults.contains(false)) {
        return Failure(ScanErrorFailure());
      }

      // 4. Return the successful list of paths
      return Success(scannedPaths);
    } catch (e) {
      return Failure(ScanErrorFailure());
    }
  }

}
