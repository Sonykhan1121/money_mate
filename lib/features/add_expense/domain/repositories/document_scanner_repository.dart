import '../../data/models/result.dart';
import '../../../../core/errors/scan_failure.dart';

abstract class DocumentScannerRepository {
  Future<Result<List<String>, ScanFailure>> scanDocumentAsImages({int page = 4});

}
