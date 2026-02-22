import 'avatar_result.dart';
import 'avatar_assets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/utils/constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvatarPickerDialog extends StatefulWidget {
  final AvatarResult? current;

  const AvatarPickerDialog({super.key, this.current});

  @override
  State<AvatarPickerDialog> createState() => _AvatarPickerDialogState();
}

class _AvatarPickerDialogState extends State<AvatarPickerDialog>
    with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;
  String? _hoveredPath;

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: AvatarAssets.groups.length, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  void _select(AvatarResult result) => Navigator.of(context).pop(result);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 60.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _DialogHeader(),
          _CustomPhotoRow(onSelect: _select),
          _GroupTabs(controller: _tabCtrl),
          _CharacterGrid(tabCtrl: _tabCtrl, onSelect: _select),
          SizedBox(height: 12.h),
        ],
      ),
    );
  }
}

// ─── Header ───────────────────────────────────────────────────────────────────

class _DialogHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 8.w, 0),
      child: Row(
        children: [
          Text(
            'Choose Avatar',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close_rounded),
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }
}

// ─── Custom photo row (camera + gallery) ─────────────────────────────────────

class _CustomPhotoRow extends StatelessWidget {
  final void Function(AvatarResult) onSelect;

   _CustomPhotoRow({required this.onSelect});

  Future<void> _pick(BuildContext context, ImageSource source) async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: source, imageQuality: 85);
    if (file != null) onSelect(AvatarResult.file(file.path));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: Row(
        children: [
          Expanded(
            child: _PhotoButton(
              icon: Icons.camera_alt_rounded,
              label: 'Camera',
              onTap: () => _pick(context, ImageSource.camera),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: _PhotoButton(
              icon: Icons.photo_library_rounded,
              label: 'Gallery',
              onTap: () => _pick(context, ImageSource.gallery),
            ),
          ),
        ],
      ),
    );
  }
}

class _PhotoButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _PhotoButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: DColors.primary.withOpacity(0.07),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: DColors.primary.withOpacity(0.18),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18.sp, color: DColors.primary),
            SizedBox(width: 6.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: DColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Tab bar ──────────────────────────────────────────────────────────────────

class _GroupTabs extends StatelessWidget {
  final TabController controller;

  const _GroupTabs({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: TabBar(
        controller: controller,
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        dividerColor: Colors.transparent,
        indicator: BoxDecoration(
          color: DColors.primary,
          borderRadius: BorderRadius.circular(8.r),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Colors.white,
        unselectedLabelColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.55),
        labelStyle: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
        tabs: AvatarAssets.groups.map((g) {
          return Tab(text: '${g.emoji} ${g.label}');
        }).toList(),
      ),
    );
  }
}

// ─── Character grid ───────────────────────────────────────────────────────────

class _CharacterGrid extends StatelessWidget {
  final TabController tabCtrl;
  final void Function(AvatarResult) onSelect;

  const _CharacterGrid({required this.tabCtrl, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220.h,
      child: TabBarView(
        controller: tabCtrl,
        children: AvatarAssets.groups.map((group) {
          return _GroupGrid(group: group, onSelect: onSelect);
        }).toList(),
      ),
    );
  }
}

class _GroupGrid extends StatelessWidget {
  final AvatarGroup group;
  final void Function(AvatarResult) onSelect;

  const _GroupGrid({required this.group, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    if (group.assets.isEmpty) return _EmptyGroup(label: group.label);

    return GridView.builder(
      padding: EdgeInsets.all(14.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 10.w,
        mainAxisSpacing: 10.h,
      ),
      itemCount: group.assets.length,
      itemBuilder: (_, i) {
        return _CharacterTile(
          assetPath: group.assets[i],
          onTap: () => onSelect(AvatarResult.asset(group.assets[i])),
        );
      },
    );
  }
}

// ─── Single character tile ────────────────────────────────────────────────────

class _CharacterTile extends StatefulWidget {
  final String assetPath;
  final VoidCallback onTap;

  const _CharacterTile({required this.assetPath, required this.onTap});

  @override
  State<_CharacterTile> createState() => _CharacterTileState();
}

class _CharacterTileState extends State<_CharacterTile> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.88 : 1.0,
        duration: const Duration(milliseconds: 120),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: _pressed ? DColors.primary : Colors.transparent,
              width: 2.5,
            ),
            boxShadow: _pressed
                ? [BoxShadow(color: DColors.primary.withOpacity(0.30), blurRadius: 8)]
                : [],
          ),
          child: ClipOval(
            child: Image.asset(
              widget.assetPath,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: DColors.primary.withOpacity(0.08),
                child: Icon(Icons.person_rounded,
                    color: DColors.primary.withOpacity(0.4)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Empty group placeholder ──────────────────────────────────────────────────

class _EmptyGroup extends StatelessWidget {
  final String label;

  const _EmptyGroup({required this.label});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.image_not_supported_outlined,
              size: 36, color: Colors.grey.shade400),
          SizedBox(height: 8.h),
          Text(
            'No $label assets added yet',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}