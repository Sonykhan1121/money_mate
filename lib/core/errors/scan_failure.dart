abstract class ScanFailure {
  final String message;

  ScanFailure(this.message);
}

class CameraPermissionFailure extends ScanFailure {
  CameraPermissionFailure([super.message = "Camera permission denied"]);
}


class ScanErrorFailure extends ScanFailure {
  ScanErrorFailure([super.message = "Scan error"]) ;
}

class StorageFailure extends ScanFailure {
  StorageFailure([super.message = "Storage error"]);
}

class FileSizeFailure extends ScanFailure {
  FileSizeFailure([super.message = "File size error"]);
}

class NotFoundFailure extends ScanFailure {
  NotFoundFailure([super.message = "Document Not found"]);
}
