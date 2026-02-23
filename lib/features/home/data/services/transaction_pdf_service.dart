import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import '../../../transactions/data/models/transactionType.dart';
import '../../../transactions/data/models/transactionModel.dart';

class TransactionPdfService {
  // ─── Colors ───────────────────────────────────────────────────────────────
  static const _primary = PdfColor.fromInt(0xFF6C63FF);
  static const _income  = PdfColor.fromInt(0xFF00C48C);
  static const _expense = PdfColor.fromInt(0xFFFF6B6B);
  static const _bgLight = PdfColor.fromInt(0xFFF8F9FA);
  static const _grey    = PdfColor.fromInt(0xFF9E9E9E);
  static const _dark    = PdfColor.fromInt(0xFF1A1A2E);
  static const _white   = PdfColors.white;

  // ─── Main Entry ───────────────────────────────────────────────────────────
  static Future<void> generateAndShare({
    required List<TransactionModel> transactions,
    required String Function(String categoryId) getCategoryName,
    String reportTitle = 'Money Mate Report',
    DateTime? from,
    DateTime? to,
  }) async {
    final pdf = pw.Document();

    // ── Calculations ──────────────────────────────────────────────────────
    final incomeList  = transactions.where((t) => t.type == TransactionType.income).toList();
    final expenseList = transactions.where((t) => t.type == TransactionType.expense).toList();

    final totalIncome  = incomeList.fold(0.0,  (s, t) => s + t.amount);
    final totalExpense = expenseList.fold(0.0, (s, t) => s + t.amount);
    final netBalance   = totalIncome - totalExpense;

    // ── Category breakdown ────────────────────────────────────────────────
    final Map<String, double> categoryTotals = {};
    for (final t in expenseList) {
      categoryTotals[t.categoryId] =
          (categoryTotals[t.categoryId] ?? 0) + t.amount;
    }
    final sortedCategories = categoryTotals.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    // ── Fonts ─────────────────────────────────────────────────────────────
    final font      = pw.Font.helvetica();
    final fontBold  = pw.Font.helveticaBold();
    final fontLight = pw.Font.helvetica();

    pdf.addPage(
      pw.MultiPage(
        pageTheme: pw.PageTheme(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(32),
          theme: pw.ThemeData.withFont(base: font, bold: fontBold),
        ),
        header: (context) => _buildHeader(reportTitle, from, to, fontBold),
        footer: (context) => _buildFooter(context, font),
        build: (context) => [
          pw.SizedBox(height: 20),
          _buildSummaryCards(totalIncome, totalExpense, netBalance, fontBold, font),
          pw.SizedBox(height: 24),
          _buildSectionTitle('Category Breakdown (Expenses)', fontBold),
          pw.SizedBox(height: 8),
          _buildCategoryTable(sortedCategories, totalExpense, font, fontBold, getCategoryName),
          pw.SizedBox(height: 24),
          _buildSectionTitle('Transaction Details', fontBold),
          pw.SizedBox(height: 8),
          _buildTransactionTable(transactions, font, fontBold, fontLight, getCategoryName),
        ],
      ),
    );

    final bytes = await pdf.save();

    final output = await getTemporaryDirectory();
    final file   = File('${output.path}/money_mate_report.pdf');
    await file.writeAsBytes(bytes);

    await Printing.sharePdf(
      bytes: bytes,
      filename: 'money_mate_report_${DateFormat('yyyy_MM_dd').format(DateTime.now())}.pdf',
    );
  }

  // ─── Header ───────────────────────────────────────────────────────────────
  static pw.Widget _buildHeader(
      String title,
      DateTime? from,
      DateTime? to,
      pw.Font fontBold,
      ) {
    final dateRange = from != null && to != null
        ? '${DateFormat('MMM d, yyyy').format(from)} - ${DateFormat('MMM d, yyyy').format(to)}'
        : DateFormat('MMMM yyyy').format(DateTime.now());

    return pw.Container(
      padding: const pw.EdgeInsets.only(bottom: 12),
      decoration: const pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(color: _primary, width: 2),
        ),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                title,
                style: pw.TextStyle(font: fontBold, fontSize: 22, color: _dark),
              ),
              pw.SizedBox(height: 4),
              pw.Text(
                dateRange,
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

  // ─── Footer ───────────────────────────────────────────────────────────────
  static pw.Widget _buildFooter(pw.Context context, pw.Font font) {
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
            'Page ${context.pageNumber} of ${context.pagesCount}',
            style: pw.TextStyle(font: font, fontSize: 9, color: _grey),
          ),
        ],
      ),
    );
  }

  // ─── Summary Cards ────────────────────────────────────────────────────────
  static pw.Widget _buildSummaryCards(
      double income,
      double expense,
      double net,
      pw.Font fontBold,
      pw.Font font,
      ) {
    return pw.Row(
      children: [
        pw.Expanded(
          child: _summaryCard('Total Income', '+ ${_fmt(income)}', _income, fontBold, font),
        ),
        pw.SizedBox(width: 12),
        pw.Expanded(
          child: _summaryCard('Total Expense', '- ${_fmt(expense)}', _expense, fontBold, font),
        ),
        pw.SizedBox(width: 12),
        pw.Expanded(
          child: _summaryCard(
            'Net Balance',
            '${net >= 0 ? '+' : '-'} ${_fmt(net.abs())}',
            net >= 0 ? _income : _expense,
            fontBold,
            font,
          ),
        ),
      ],
    );
  }

  static pw.Widget _summaryCard(
      String label,
      String value,
      PdfColor color,
      pw.Font fontBold,
      pw.Font font,
      ) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(14),
      decoration: pw.BoxDecoration(
        color: _bgLight,
        borderRadius: pw.BorderRadius.circular(8),
        border: pw.Border.all(color: color, width: 1),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(label,
              style: pw.TextStyle(font: font, fontSize: 10, color: _grey)),
          pw.SizedBox(height: 6),
          pw.Text(value,
              style: pw.TextStyle(font: fontBold, fontSize: 14, color: color)),
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

  // ─── Category Table ───────────────────────────────────────────────────────
  static pw.Widget _buildCategoryTable(
      List<MapEntry<String, double>> categories,
      double totalExpense,
      pw.Font font,
      pw.Font fontBold,
      String Function(String) getCategoryName,
      ) {
    if (categories.isEmpty) {
      return pw.Text('No expense data.',
          style: pw.TextStyle(font: font, color: _grey));
    }

    return pw.Table(
      border: pw.TableBorder.all(color: _bgLight, width: 1),
      columnWidths: {
        0: const pw.FlexColumnWidth(3),
        1: const pw.FlexColumnWidth(2),
        2: const pw.FlexColumnWidth(2),
      },
      children: [
        // Header
        pw.TableRow(
          decoration: const pw.BoxDecoration(color: _primary),
          children: ['Category', 'Amount', '% of Total'].map((h) =>
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: pw.Text(h,
                    style: pw.TextStyle(font: fontBold, color: _white, fontSize: 10)),
              ),
          ).toList(),
        ),
        // Rows
        ...categories.asMap().entries.map((entry) {
          final i      = entry.key;
          final cat    = entry.value;
          final pct    = totalExpense > 0
              ? (cat.value / totalExpense * 100).toStringAsFixed(1)
              : '0.0';
          final bgColor = i.isEven ? _white : _bgLight;

          return pw.TableRow(
            decoration: pw.BoxDecoration(color: bgColor),
            children: [
              getCategoryName(cat.key), // ✅ category name from id
              '${_fmt(cat.value)}',
              '$pct%',
            ].map((cell) =>
                pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                  child: pw.Text(cell,
                      style: pw.TextStyle(font: font, fontSize: 10, color: _dark)),
                ),
            ).toList(),
          );
        }),
      ],
    );
  }

  // ─── Transaction Table ────────────────────────────────────────────────────
  static pw.Widget _buildTransactionTable(
      List<TransactionModel> transactions,
      pw.Font font,
      pw.Font fontBold,
      pw.Font fontLight,
      String Function(String) getCategoryName,
      ) {
    if (transactions.isEmpty) {
      return pw.Text('No transactions found.',
          style: pw.TextStyle(font: font, color: _grey));
    }

    final sorted = [...transactions]
      ..sort((a, b) => b.customDate.compareTo(a.customDate));

    return pw.Table(
      border: pw.TableBorder.all(color: _bgLight, width: 1),
      columnWidths: {
        0: const pw.FlexColumnWidth(2),
        1: const pw.FlexColumnWidth(3),
        2: const pw.FlexColumnWidth(2),
        3: const pw.FlexColumnWidth(1.5),
      },
      children: [
        // Header
        pw.TableRow(
          decoration: const pw.BoxDecoration(color: _primary),
          children: ['Date', 'Category', 'Amount', 'Type'].map((h) =>
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: pw.Text(h,
                    style: pw.TextStyle(font: fontBold, color: _white, fontSize: 9)),
              ),
          ).toList(),
        ),
        // Rows
        ...sorted.asMap().entries.map((entry) {
          final i        = entry.key;
          final t        = entry.value;
          final isIncome = t.type == TransactionType.income;
          final bgColor  = i.isEven ? _white : _bgLight;
          final amtColor = isIncome ? _income : _expense;
          final amtText  = '${isIncome ? '+' : '-'} ${_fmt(t.amount)}';

          return pw.TableRow(
            decoration: pw.BoxDecoration(color: bgColor),
            children: [
              // Date
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: pw.Text(
                  DateFormat('MMM d, yy').format(t.customDate),
                  style: pw.TextStyle(font: fontLight, fontSize: 9, color: _grey),
                ),
              ),
              // Category name
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: pw.Text(
                  getCategoryName(t.categoryId), // ✅
                  style: pw.TextStyle(font: font, fontSize: 9, color: _dark),
                ),
              ),
              // Amount
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: pw.Text(
                  amtText,
                  style: pw.TextStyle(font: fontBold, fontSize: 9, color: amtColor),
                ),
              ),
              // Type
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: pw.Container(
                  padding: const pw.EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  decoration: pw.BoxDecoration(
                    color: isIncome ? _income.shade(0.15) : _expense.shade(0.15),
                    borderRadius: pw.BorderRadius.circular(4),
                  ),
                  child: pw.Text(
                    isIncome ? 'Income' : 'Expense',
                    style: pw.TextStyle(
                      font: fontBold,
                      fontSize: 8,
                      color: isIncome ? _income : _expense,
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ],
    );
  }

  // ─── Helper ───────────────────────────────────────────────────────────────
  static String _fmt(double amount) =>
      NumberFormat('#,##0.00', 'en_US').format(amount);
}