import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../transactions/data/models/transaction_type.dart';
import '../../data/models/category.dart';

class CategoryDropdownItem extends StatelessWidget {
  final CategoryModel category;

  const CategoryDropdownItem({super.key, required this.category});

  Color get _color {
    final hex = category.colorHex.replaceFirst('#', '');
    return Color(int.parse('FF$hex', radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        // ── Colored icon bubble ──
        Container(
          width: 20.w,
          height: 20.w,
          decoration: BoxDecoration(
            color: _color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: _color.withValues(alpha: 0.3), width: 1),
          ),
          child: Center(
            child: Text(category.icon, style: TextStyle(fontSize: 10.sp)),
          ),
        ),

        SizedBox(width: 10.w),

        // ── Name + localised ──
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                category.name,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                category.nameLocalised,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.45),
                ),
              ),
            ],
          ),
        ),

        // ── Type badge ──
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
          decoration: BoxDecoration(
            color: category.type == TransactionType.income
                ? Colors.green.withValues(alpha: 0.12)
                : Colors.red.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Text(
            category.type == TransactionType.income ? 'Income' : 'Expense',
            style: TextStyle(
              fontSize: 9.sp,
              fontWeight: FontWeight.w600,
              color: category.type == TransactionType.income
                  ? Colors.green.shade700
                  : Colors.red.shade700,
            ),
          ),
        ),
      ],
    );
  }
}


// ─── Compact item shown in the field after selection ─────────────────────────
class CategorySelectedItem extends StatelessWidget {
  final CategoryModel category;

  const CategorySelectedItem({super.key, required this.category});

  Color get _color {
    final hex = category.colorHex.replaceFirst('#', '');
    return Color(int.parse('FF$hex', radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(category.icon, style: TextStyle(fontSize: 10.sp)),
        SizedBox(width: 8.w),
        Text(
          category.name,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(width: 6.w),
        Container(
          width: 8.w,
          height: 8.w,
          decoration: BoxDecoration(
            color: _color,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}