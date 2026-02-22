import 'dart:io';

enum AvatarType { asset, file }

/// Holds the result of an avatar selection.
/// - [type] == asset  → [path] is an asset string  e.g. 'assets/avatars/spiderman.png'
/// - [type] == file   → [path] is a file system path from camera/gallery
class AvatarResult {
  final AvatarType type;
  final String path;

  const AvatarResult.asset(this.path) : type = AvatarType.asset;
  const AvatarResult.file(this.path)  : type = AvatarType.file;

  /// Returns a [File] only when type is file, null otherwise.
  File? toFile() => type == AvatarType.file ? File(path) : null;

  @override
  String toString() => 'AvatarResult($type, $path)';
}