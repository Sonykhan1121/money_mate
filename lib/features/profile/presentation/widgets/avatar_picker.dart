import 'avatar_result.dart';
import 'avatar_picker_dialog.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvatarPicker extends StatefulWidget {
  final AvatarResult? initial;
  final void Function(AvatarResult result)? onAvatarSelected;

  const AvatarPicker({super.key, this.onAvatarSelected,this.initial});

  @override
  State<AvatarPicker> createState() => _AvatarPickerState();
}

class _AvatarPickerState extends State<AvatarPicker> {
  AvatarResult? _selected;

  void _openDialog() async {
    final result = await showDialog<AvatarResult>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.55),
      builder: (_) => AvatarPickerDialog(current: _selected),
    );

    if (result != null) {
      setState(() => _selected = result);
      widget.onAvatarSelected?.call(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _openDialog,
      child: _AvatarStack(selected: _selected),
    );
  }
}

// ─── Stack: circle + camera badge ────────────────────────────────────────────

class _AvatarStack extends StatelessWidget {
  final AvatarResult? selected;

  const _AvatarStack({this.selected});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        _AvatarCircle(selected: selected),
        _CameraBadge(),
      ],
    );
  }
}

// ─── Circle ───────────────────────────────────────────────────────────────────

class _AvatarCircle extends StatelessWidget {
  final AvatarResult? selected;

  const _AvatarCircle({this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72.w,
      height: 72.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: DColors.primary.withOpacity(0.10),
        border: Border.all(
          color: DColors.primary.withOpacity(0.30),
          width: 2,
        ),
      ),
      child: ClipOval(child: _AvatarContent(selected: selected)),
    );
  }
}

// ─── Content inside circle ────────────────────────────────────────────────────

class _AvatarContent extends StatelessWidget {
  final AvatarResult? selected;

  const _AvatarContent({this.selected});

  @override
  Widget build(BuildContext context) {
    if (selected == null) {
      return Icon(
        Icons.person_rounded,
        size: 38.sp,
        color: DColors.primary.withOpacity(0.55),
      );
    }

    if (selected!.type == AvatarType.asset) {
      return Image.asset(selected!.path, fit: BoxFit.cover);
    }

    // File path (custom photo)
    return Image.file(
      selected!.toFile()!,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => Icon(
        Icons.person_rounded,
        size: 38.sp,
        color: DColors.primary.withOpacity(0.55),
      ),
    );
  }
}

// ─── Camera badge ─────────────────────────────────────────────────────────────

class _CameraBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: Container(
        width: 22.w,
        height: 22.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: DColors.primary,
          border: Border.all(color: Colors.white, width: 1.5),
        ),
        child: Icon(
          Icons.camera_alt_rounded,
          size: 12.sp,
          color: Colors.white,
        ),
      ),
    );
  }
}