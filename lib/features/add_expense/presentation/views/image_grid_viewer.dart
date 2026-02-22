import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/image_thumbnail.dart';
import '../viewmodels/add_expense_provider.dart';

class ImageGridViewer extends StatefulWidget {
  final double spacing;
  const ImageGridViewer({super.key, this.spacing = 10});

  @override
  State<ImageGridViewer> createState() => _ImageGridViewerState();
}

class _ImageGridViewerState extends State<ImageGridViewer> {
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<AddExpenseProvider>(
      builder: (BuildContext context, AddExpenseProvider addExpenseProvider, Widget? child) {
        if (addExpenseProvider.imagePaths.isEmpty) return const _EmptyState();

        return Wrap(
          spacing: widget.spacing,
          runSpacing: widget.spacing,
          children: List.generate(
            addExpenseProvider.imagePaths.length,
            (i) => ImageThumbnail(imagePath: addExpenseProvider.imagePaths[i], onRemove: () =>  addExpenseProvider.removeImagePath(i)),
          ),
        );
      },
    );
  }
}

// ─── Empty State ─────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.photo_library_outlined, size: 48, color: Colors.grey.shade400),
          const SizedBox(height: 8),
          Text('No images', style: TextStyle(color: Colors.grey.shade500)),
        ],
      ),
    );
  }
}
