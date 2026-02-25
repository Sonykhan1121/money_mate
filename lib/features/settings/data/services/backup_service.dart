import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../../../transactions/data/models/transactionModel.dart';
import '../../../transactions/domain/repositories/transaction_repository.dart';

class BackupService {

  // ─── Backup ───────────────────────────────────────────────────────────────
  static Future<BackupResult> backup({
    required List<TransactionModel> transactions,
    required BuildContext context,
  }) async {
    try {
      final List<Map<String, dynamic>> jsonList = [];

      for (final t in transactions) {
        final Map<String, dynamic> json = t.toJson();

        if (t.imageUrls != null && t.imageUrls!.isNotEmpty) {
          final List<String> base64Images = [];
          for (final path in t.imageUrls!) {
            final file = File(path);
            if (await file.exists()) {
              final bytes  = await file.readAsBytes();
              final ext    = path.split('.').last.toLowerCase();
              final b64    = base64Encode(bytes);
              base64Images.add('data:image/$ext;base64,$b64');
            }
          }
          json['imageUrls_base64'] = base64Images;
          json['imageUrls']        = [];   // clear stale paths
        }

        jsonList.add(json);
      }

      final backupData = {
        'version':      1,
        'exportedAt':   DateTime.now().toIso8601String(),
        'count':        transactions.length,
        'transactions': jsonList,
      };

      final fileName = 'moneymate_backup_${DateTime.now().millisecondsSinceEpoch}.json';
      final content  = jsonEncode(backupData);

      // ── 1. Save to Downloads ─────────────────────────────────────────────
      String? savedPath;
      try {
        if (Platform.isAndroid) {
          final downloadsDir = Directory('/storage/emulated/0/Download');
          if (await downloadsDir.exists()) {
            final savedFile = File('${downloadsDir.path}/$fileName');
            await savedFile.writeAsString(content, flush: true);
            savedPath = savedFile.path;
          }
        }
      } catch (_) { /* skip, share below */ }

      // ── 2. Share ─────────────────────────────────────────────────────────
      final tempFile = File('${(await getTemporaryDirectory()).path}/$fileName');
      await tempFile.writeAsString(content, flush: true);
      await Share.shareXFiles(
        [XFile(tempFile.path)],
        text: 'MoneyMate Backup — ${transactions.length} transactions',
      );

      return BackupResult.success(transactions.length, savedPath: savedPath);
    } catch (e) {
      return BackupResult.failure(e.toString());
    }
  }

  // ─── Restore ──────────────────────────────────────────────────────────────
  static Future<RestoreResult> restore({
    required TransactionRepository repository,
  }) async {
    try {
      // ── Pick file ────────────────────────────────────────────────────────
      final picked = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
        allowMultiple: false,
      );

      if (picked == null || picked.files.isEmpty) return RestoreResult.cancelled();

      final filePath = picked.files.single.path;
      if (filePath == null) return RestoreResult.failure('Could not read file path');

      // ── Decode ───────────────────────────────────────────────────────────
      final content = await File(filePath).readAsString();
      final decoded = jsonDecode(content) as Map<String, dynamic>;

      if (!decoded.containsKey('transactions')) {
        return RestoreResult.failure('Invalid backup file — missing transactions key');
      }

      // ── Prepare image directory ──────────────────────────────────────────
      final appDir = await getApplicationDocumentsDirectory();
      final imgDir = Directory('${appDir.path}/restored_images');
      if (!await imgDir.exists()) await imgDir.create(recursive: true);

      final List txList  = decoded['transactions'] as List;
      int       imported = 0;

      for (final item in txList) {
        final Map<String, dynamic> json = Map<String, dynamic>.from(item);

        // ── FIX 1: Always clear old stale paths first ─────────────────────
        json['imageUrls'] = <String>[];

        // ── FIX 2: Restore base64 → real image files ──────────────────────
        if (json['imageUrls_base64'] != null) {
          final List          base64List     = json['imageUrls_base64'] as List;
          final List<String>  restoredPaths  = [];

          for (int i = 0; i < base64List.length; i++) {
            final String data  = base64List[i] as String;
            final match        = RegExp(r'data:image/(\w+);base64,(.+)').firstMatch(data);
            if (match == null) continue;

            final ext     = match.group(1) ?? 'jpg';
            final b64Data = match.group(2) ?? '';
            final bytes   = base64Decode(b64Data);

            // ── FIX 3: Unique filename using tx id + index (not timestamp) ─
            final txId    = json['id']?.toString() ?? 'unknown';
            final imgPath = '${imgDir.path}/tx_${txId}_img_$i.$ext';

            await File(imgPath).writeAsBytes(bytes, flush: true);
            restoredPaths.add(imgPath);
          }

          json['imageUrls'] = restoredPaths;   // replace with real paths
        }

        json.remove('imageUrls_base64');        // clean up before parsing

        // ── FIX 4: Use upsert not update (handles both new + existing) ─────
        final transaction = TransactionModel.fromJson(json);
        print('saving tn : $transaction');
        await repository.updateTransaction(transaction);
        imported++;
      }

      return RestoreResult.success(imported);

    } on FileSystemException catch (e) {
      return RestoreResult.failure('File error: ${e.message}');
    } catch (e) {
      return RestoreResult.failure(e.toString());
    }
  }
}

// ─── Result Classes ───────────────────────────────────────────────────────────
class BackupResult {
  final bool    success;
  final int?    count;
  final String? error;
  final String? savedPath;

  BackupResult._({required this.success, this.count, this.error, this.savedPath});

  factory BackupResult.success(int count, {String? savedPath}) =>
      BackupResult._(success: true, count: count, savedPath: savedPath);
  factory BackupResult.failure(String error) =>
      BackupResult._(success: false, error: error);
}

class RestoreResult {
  final bool    success;
  final bool    cancelled;
  final int?    count;
  final String? error;

  RestoreResult._({required this.success, this.cancelled = false, this.count, this.error});

  factory RestoreResult.success(int count)    => RestoreResult._(success: true,  count: count);
  factory RestoreResult.cancelled()           => RestoreResult._(success: false, cancelled: true);
  factory RestoreResult.failure(String error) => RestoreResult._(success: false, error: error);
}