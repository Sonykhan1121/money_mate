import 'dart:io';

import 'package:flutter/material.dart';

import 'digalog_close_button.dart';

class ImagePreviewDialog extends StatelessWidget {
  final String imagePath;

  const ImagePreviewDialog({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          _DialogImageContent(imagePath: imagePath),
          const DialogCloseButton(),
        ],
      ),
    );
  }
}

// ─── Private: image content inside the dialog ───────────────────────────────

class _DialogImageContent extends StatelessWidget {
  final String imagePath;

  const _DialogImageContent({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: InteractiveViewer(
        child: Image.file(
          File(imagePath),
          fit: BoxFit.contain,

          errorBuilder: (context, error, stackTrace) {
            return const _ImageErrorPlaceholder();
          },
        ),
      ),
    );
  }
}

// ─── Private: error state ────────────────────────────────────────────────────

class _ImageErrorPlaceholder extends StatelessWidget {
  const _ImageErrorPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      color: Colors.grey.shade900,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.broken_image_outlined, color: Colors.white54, size: 48),
          SizedBox(height: 8),
          Text(
            'Image not available',
            style: TextStyle(color: Colors.white54),
          ),
        ],
      ),
    );
  }
}