

class AvatarAssets {
  AvatarAssets._();

  static const List<AvatarGroup> groups = [
    AvatarGroup(
      label: 'Marvel',
      emoji: '🕷',
      assets: [
        'assets/avatars/marvel/spiderman.png',
        'assets/avatars/marvel/ironman.png',
        'assets/avatars/marvel/blackwidow.png',
        'assets/avatars/marvel/thor.png',
        'assets/avatars/marvel/thor_hammer.png',
        'assets/avatars/marvel/captain_america.png',
        'assets/avatars/marvel/hulk.png',
      ],
    ),
    AvatarGroup(
      label: 'DC',
      emoji: '🦇',
      assets: [
        'assets/avatars/dc/batman.png',
        'assets/avatars/dc/superman.png',
        'assets/avatars/dc/wonderwoman.png',
        'assets/avatars/dc/flash.png',
        'assets/avatars/dc/aquaman.png',
      ],
    ),

  ];
}

class AvatarGroup {
  final String label;
  final String emoji;
  final List<String> assets;

  const AvatarGroup({
    required this.label,
    required this.emoji,
    required this.assets,
  });
}