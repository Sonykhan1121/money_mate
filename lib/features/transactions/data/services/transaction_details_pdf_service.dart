import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import '../../../transactions/data/models/transaction_type.dart';
import '../../../transactions/data/models/transaction_model.dart';

class TransactionDetailPdfService {

  // ─── Colors ───────────────────────────────────────────────────────────────
  static const _primary   = PdfColor.fromInt(0xFF6C63FF);
  static const _income    = PdfColor.fromInt(0xFF00C48C);
  static const _expense   = PdfColor.fromInt(0xFFFF6B6B);
  static const _bgLight   = PdfColor.fromInt(0xFFF8F9FA);
  static const _grey      = PdfColor.fromInt(0xFF9E9E9E);
  static const _dark      = PdfColor.fromInt(0xFF1A1A2E);
  static const _white     = PdfColors.white;

  // ─── Main Entry ───────────────────────────────────────────────────────────
  static Future<void> generateAndShare({
    required TransactionModel transaction,
    required String Function(String categoryId) getCategoryName,
    required String categoryIcon,
  }) async {
    final pdf      = pw.Document();
    final font     = pw.Font.helvetica();
    final fontBold = pw.Font.helveticaBold();

    final isIncome = transaction.type == TransactionType.income;
    final color    = isIncome ? _income : _expense;

    pdf.addPage(
      pw.Page(
        pageTheme: pw.PageTheme(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(32),
          theme: pw.ThemeData.withFont(base: font, bold: fontBold),
        ),
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            _buildHeader(fontBold),
            pw.SizedBox(height: 32),
            _buildAmountHero(transaction, color, isIncome, fontBold),
            pw.SizedBox(height: 28),
            _buildSectionTitle('Transaction Details', fontBold),
            pw.SizedBox(height: 12),
            _buildDetailsCard(transaction, getCategoryName, font, fontBold),
            if (transaction.imageUrls != null && transaction.imageUrls!.isNotEmpty) ...[
              pw.SizedBox(height: 28),
              _buildSectionTitle('Attachments (${transaction.imageUrls!.length})', fontBold),
              pw.SizedBox(height: 12),
              _buildAttachments(transaction.imageUrls!),
            ],
            pw.Spacer(),
            _buildFooter(font),
          ],
        ),
      ),
    );

    final bytes  = await pdf.save();
    final output = await getTemporaryDirectory();
    final file   = File('${output.path}/transaction_${transaction.id}.pdf');
    await file.writeAsBytes(bytes);

    await Printing.sharePdf(
      bytes: bytes,
      filename: 'transaction_${transaction.id}_${DateFormat('yyyy_MM_dd').format(DateTime.now())}.pdf',
    );
  }

  // ─── Header ───────────────────────────────────────────────────────────────
  static pw.Widget _buildHeader(pw.Font fontBold) {
    return pw.Container(
      padding: const pw.EdgeInsets.only(bottom: 12),
      decoration: const pw.BoxDecoration(
        border: pw.Border(bottom: pw.BorderSide(color: _primary, width: 2)),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Transaction Detail',
                style: pw.TextStyle(font: fontBold, fontSize: 22, color: _dark),
              ),
              pw.SizedBox(height: 4),
              pw.Text(
                DateFormat('MMMM yyyy').format(DateTime.now()),
                style: pw.TextStyle(fontSize: 11, color: _grey),
              ),
            ],
          ),
          pw.Container(
            padding: const pw.EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: pw.BoxDecoration(
              color: _primary,
              borderRadius: pw.BorderRadius.circular(6),
            ),
            child: pw.Text(
              'MoneyMate',
              style: pw.TextStyle(font: fontBold, color: _white, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Amount Hero ──────────────────────────────────────────────────────────
  static pw.Widget _buildAmountHero(
      TransactionModel transaction,
      PdfColor color,
      bool isIncome,
      pw.Font fontBold,
      ) {
    return pw.Center(
      child: pw.Container(
        padding: const pw.EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        decoration: pw.BoxDecoration(
          color: color,
          borderRadius: pw.BorderRadius.circular(16),
        ),
        child: pw.Column(
          children: [
            pw.Text(
              '${isIncome ? '+' : '-'} ${_fmt(transaction.amount)}',
              style: pw.TextStyle(font: fontBold, fontSize: 36, color: _white),
            ),
            pw.SizedBox(height: 8),
            pw.Container(
              padding: const pw.EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              decoration: pw.BoxDecoration(
                color: PdfColors.white,
                borderRadius: pw.BorderRadius.circular(20),
              ),
              child: pw.Text(
                isIncome ? 'Income' : 'Expense',
                style: pw.TextStyle(font: fontBold, fontSize: 11, color: color),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Details Card ─────────────────────────────────────────────────────────
  static pw.Widget _buildDetailsCard(
      TransactionModel transaction,
      String Function(String) getCategoryName,
      pw.Font font,
      pw.Font fontBold,
      ) {
    // Build only rows that have data
    final rows = <pw.Widget>[];

    void addRow(String label, String? value) {
      if (value == null || value.trim().isEmpty) return;
      if (rows.isNotEmpty) rows.add(_divider());
      rows.add(_detailRow(label, value, font, fontBold));
    }

    addRow('Title',          transaction.title);
    addRow('Category',       getCategoryName(transaction.categoryId));
    addRow('Date',           DateFormat('EEEE, MMM d, yyyy').format(transaction.customDate));
    addRow('Created At',     DateFormat('MMM d, yyyy  hh:mm a').format(transaction.createdAt));
    addRow('Payment',        transaction.paymentMethod);
    addRow('Location',       transaction.location);
    addRow('Tags',           transaction.tags?.join(', '));
    addRow('Description',    transaction.description);
    addRow('Notes',          transaction.notes);

    return pw.Container(
      decoration: pw.BoxDecoration(
        color: _bgLight,
        borderRadius: pw.BorderRadius.circular(10),
        border: pw.Border.all(color: _primary, width: 0.5),
      ),
      child: pw.Column(children: rows),
    );
  }

  // ─── Attachments ──────────────────────────────────────────────────────────
  static pw.Widget _buildAttachments(List<String> imageUrls) {
    final images = <pw.Widget>[];

    for (final path in imageUrls) {
      final file = File(path);
      if (!file.existsSync()) continue;

      images.add(
        pw.Container(
          width: 120,
          height: 120,
          decoration: pw.BoxDecoration(
            borderRadius: pw.BorderRadius.circular(8),
            border: pw.Border.all(color: _grey, width: 0.5),
          ),
          child: pw.ClipRRect(
            horizontalRadius: 8,
            verticalRadius: 8,
            child: pw.Image(
              pw.MemoryImage(file.readAsBytesSync()),
              fit: pw.BoxFit.cover,
            ),
          ),
        ),
      );
    }

    return pw.Wrap(spacing: 10, runSpacing: 10, children: images);
  }

  // ─── Footer ───────────────────────────────────────────────────────────────
  static pw.Widget _buildFooter(pw.Font font) {
    return pw.Container(
      padding: const pw.EdgeInsets.only(top: 8),
      decoration: const pw.BoxDecoration(
        border: pw.Border(top: pw.BorderSide(color: _grey, width: 0.5)),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            'Generated by MoneyMate - ${DateFormat('MMM d, yyyy').format(DateTime.now())}',
            style: pw.TextStyle(font: font, fontSize: 9, color: _grey),
          ),
          pw.Text(
            'Transaction Receipt',
            style: pw.TextStyle(font: font, fontSize: 9, color: _grey),
          ),
        ],
      ),
    );
  }

  // ─── Section Title ────────────────────────────────────────────────────────
  static pw.Widget _buildSectionTitle(String title, pw.Font fontBold) {
    return pw.Container(
      padding: const pw.EdgeInsets.only(left: 8),
      decoration: const pw.BoxDecoration(
        border: pw.Border(left: pw.BorderSide(color: _primary, width: 3)),
      ),
      child: pw.Text(
        title,
        style: pw.TextStyle(font: fontBold, fontSize: 13, color: _dark),
      ),
    );
  }

  // ─── Detail Row ───────────────────────────────────────────────────────────
  static pw.Widget _detailRow(
      String label,
      String value,
      pw.Font font,
      pw.Font fontBold,
      ) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(
            width: 110,
            child: pw.Text(
              label,
              style: pw.TextStyle(font: font, fontSize: 10, color: _grey),
            ),
          ),
          pw.Expanded(
            child: pw.Text(
              value,
              style: pw.TextStyle(font: fontBold, fontSize: 10, color: _dark),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Divider ──────────────────────────────────────────────────────────────
  static pw.Widget _divider() {
    return pw.Container(
      margin: const pw.EdgeInsets.symmetric(horizontal: 16),
      decoration: const pw.BoxDecoration(
        border: pw.Border(bottom: pw.BorderSide(color: _grey, width: 0.3)),
      ),
    );
  }

  // ─── Helper ───────────────────────────────────────────────────────────────
  static String _fmt(double amount) =>
      NumberFormat('#,##0.00', 'en_US').format(amount);
}