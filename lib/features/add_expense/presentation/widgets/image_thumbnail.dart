import 'dart:io';

import 'package:flutter/material.dart';
import 'image_preview_dialog.dart';

class ImageThumbnail extends StatelessWidget {
  final String imagePath;
  final VoidCallback onRemove;

  const ImageThumbnail({
    super.key,
    required this.imagePath,
    required this.onRemove,
  });

  void _openPreview(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (_) => ImagePreviewDialog(imagePath: imagePath),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        _ThumbnailCard(imagePath: imagePath, onTap: () => _openPreview(context)),
        _RemoveButton(onTap: onRemove),
      ],
    );
  }
}

// ─── Card ────────────────────────────────────────────────────────────────────

class _ThumbnailCard extends StatelessWidget {
  final String imagePath;
  final VoidCallback onTap;

  const _ThumbnailCard({required this.imagePath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade200,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.file(
            File(imagePath),
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Icon(
              Icons.image_not_supported_outlined,
              color: Colors.grey.shade400,
              size: 32,
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Remove Button ───────────────────────────────────────────────────────────

class _RemoveButton extends StatelessWidget {
  final VoidCallback onTap;

  const _RemoveButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -6,
      right: -6,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 22,
          height: 22,
          decoration: const BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.close, color: Colors.white, size: 14),
        ),
      ),
    );
  }
}