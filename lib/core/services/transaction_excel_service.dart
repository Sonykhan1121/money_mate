import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:excel/excel.dart';
import 'package:printing/printing.dart';
import '../../features/transactions/data/models/transaction_model.dart';
import '../../features/transactions/data/models/transaction_type.dart';

class TransactionExcelService {
  // ─── Colors (as hex ints for cell fills) ──────────────────────────────────
  static const _primaryHex = 'FF6C63FF';
  static const _incomeHex = 'FF00C48C';
  static const _expenseHex = 'FFFF6B6B';
  static const _bgLightHex = 'FFF8F9FA';
  static const _greyHex = 'FF9E9E9E';
  static const _darkHex = 'FF1A1A2E';
  static const _whiteHex = 'FFFFFFFF';

  static Future<void> generateAndShare({
    required List<TransactionModel> transactions,
    required String Function(String categoryId) getCategoryName,
    String reportTitle = 'Money Mate Report',
    DateTime? from,
    DateTime? to,
  }) async {
    final excel = Excel.createExcel();
    final sheet = excel['Report']; // Use one specific sheet name

    // 1. Calculations
    final totalIncome = transactions.where((t) => t.type == TransactionType.income).fold(0.0, (s, t) => s + t.amount);
    final totalExpense = transactions.where((t) => t.type == TransactionType.expense).fold(0.0, (s, t) => s + t.amount);
    final netBalance = totalIncome - totalExpense;

    // 2. Build Header & Summary Section
    final dateRange =
        from != null && to != null
            ? '${DateFormat('MMM d, yyyy').format(from)} - ${DateFormat('MMM d, yyyy').format(to)}'
            : DateFormat('MMMM yyyy').format(DateTime.now());

    _setCell(sheet, 0, 0, reportTitle, bold: true, fontSize: 16, fgColor: _darkHex,rowHeight: 20,colWidth: 700);
    _setCell(sheet, 1, 0, dateRange, fontSize: 11, fgColor: _greyHex);

    // Summary Row Headers (Row 4)
    _setCell(sheet, 3, 0, 'Total Income', bold: true, bgColor: _primaryHex, fgColor: _whiteHex);
    _setCell(sheet, 3, 1, 'Total Expense', bold: true, bgColor: _primaryHex, fgColor: _whiteHex);
    _setCell(sheet, 3, 2, 'Net Balance', bold: true, bgColor: _primaryHex, fgColor: _whiteHex);

    // Summary Values (Row 5)
    _setCell(sheet, 4, 0, '+ ${_fmt(totalIncome)}', bold: true, fgColor: _incomeHex, bgColor: _bgLightHex);
    _setCell(sheet, 4, 1, '- ${_fmt(totalExpense)}', bold: true, fgColor: _expenseHex, bgColor: _bgLightHex);
    _setCell(
      sheet,
      4,
      2,
      '${netBalance >= 0 ? '+' : '-'} ${_fmt(netBalance.abs())}',
      bold: true,
      fgColor: netBalance >= 0 ? _incomeHex : _expenseHex,
      bgColor: _bgLightHex,
    );

    // 3. Build Transaction Table Section (Starting from Row 7)
    _setCell(sheet, 6, 0, 'Transaction Details', bold: true, fontSize: 13, fgColor: _darkHex);

    final headers = ['Date', 'Title', 'Category', 'Amount', 'Type'];
    for (int i = 0; i < headers.length; i++) {
      _setCell(sheet, 7, i, headers[i], bold: true, bgColor: _primaryHex, fgColor: _whiteHex);
    }

    final sorted = [...transactions]..sort((a, b) => b.customDate.compareTo(a.customDate));

    for (int i = 0; i < sorted.length; i++) {
      final t = sorted[i];
      final isIncome = t.type == TransactionType.income;
      final rowIndex = i + 8; // Start after the header row
      final bgColor = i.isEven ? _whiteHex : _bgLightHex;
      final title = t.title;
      final amtColor = isIncome ? _incomeHex : _expenseHex;

      _setCell(sheet, rowIndex, 0, DateFormat('MMM d, yy').format(t.customDate), bgColor: bgColor, fgColor: _greyHex);
      _setCell(sheet, rowIndex, 1, title, bgColor: bgColor, fgColor: _darkHex);
      _setCell(sheet, rowIndex, 1, getCategoryName(t.categoryId), bgColor: bgColor, fgColor: _darkHex);
      _setCell(
        sheet,
        rowIndex,
        2,
        '${isIncome ? '+' : '-'} ${_fmt(t.amount)}',
        bold: true,
        bgColor: bgColor,
        fgColor: amtColor,
      );
      _setCell(sheet, rowIndex, 3, isIncome ? 'Income' : 'Expense', bold: true, bgColor: bgColor, fgColor: amtColor);
    }

    // Column widths
    sheet.setColumnWidth(0, 20);
    sheet.setColumnWidth(1, 25);
    sheet.setColumnWidth(2, 20);
    sheet.setColumnWidth(3, 15);

    excel.delete('Sheet1'); // Remove the default sheet

    // 4. Save & Share
    final fileBytes = excel.save();
    if (fileBytes == null) return;

    await Printing.sharePdf(
      bytes: Uint8List.fromList(fileBytes),
      filename: 'money_mate_report_${DateFormat('yyyy_MM_dd').format(DateTime.now())}.xlsx',
    );
  }

  // ─── Improved Cell Helper with Sizing ──────────────────────────────────────
  static void _setCell(
      Sheet sheet,
      int row,
      int col,
      String value, {
        bool bold = false,
        double fontSize = 10,
        String? bgColor,
        String? fgColor,
        double? rowHeight, // New: Custom height for the box
        double? colWidth,  // New: Custom width for the box
        HorizontalAlign horizontalAlign = HorizontalAlign.Left,
        VerticalAlign verticalAlign = VerticalAlign.Center,
      }) {
    final cell = sheet.cell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: row));

    // Set the value
    cell.value = TextCellValue(value);

    // 1. Set the Box Size (Row Height & Column Width)
    if (rowHeight != null) {
      sheet.setRowHeight(row, rowHeight);
    }
    if (colWidth != null) {
      sheet.setColumnWidth(col, colWidth);
    }

    // 2. Set the Styling & Alignment
    cell.cellStyle = CellStyle(
      bold: bold,
      fontSize: fontSize.toInt(),
      horizontalAlign: horizontalAlign,
      verticalAlign: verticalAlign,
      backgroundColorHex: bgColor != null
          ? ExcelColor.fromHexString(bgColor)
          : ExcelColor.fromHexString('FFFFFFFF'),
      fontColorHex: fgColor != null
          ? ExcelColor.fromHexString(fgColor)
          : ExcelColor.fromHexString('FF000000'), // Default Black
    );
  }

  static String _fmt(double amount) => NumberFormat('#,##0.00', 'en_US').format(amount);
}
