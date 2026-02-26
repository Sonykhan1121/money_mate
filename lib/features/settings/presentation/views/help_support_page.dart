import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/utils/constants/colors.dart';
import '../viewmodels/app_info.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  // ─── FAQs ─────────────────────────────────────────────────────────────────
  static const _faqs = [
    (
    q: 'How do I add a transaction?',
    a: 'Tap the + button on the home screen. Fill in the amount, category, and date, then tap Save.',
    ),
    (
    q: 'Can I edit or delete a transaction?',
    a: 'Yes. Open any transaction from the list, then tap the Edit or Delete button at the bottom.',
    ),
    (
    q: 'How does backup work?',
    a: 'Go to Settings → Backup Data. This exports all your transactions as a JSON file including images. Save it to your preferred location.',
    ),
    (
    q: 'How do I restore my data?',
    a: 'Go to Settings → Import Backup Data and select the .json backup file. All transactions will be restored.',
    ),
    (
    q: 'Are my images saved in the backup?',
    a: 'Yes, images are embedded directly in the backup file as base64, so they are fully portable.',
    ),
    (
    q: 'What happens if I reinstall the app?',
    a: 'Your data will be lost unless you have a backup. Use Settings → Backup Data before reinstalling.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final appInfo = context.watch<AppInfo>();

    return Scaffold(
      appBar: AppBar(title: const Text('Help & Support')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ── FAQs ────────────────────────────────────────────────────────
            _sectionTitle('Frequently Asked Questions'),
            const SizedBox(height: 12),
            ..._faqs.map((faq) => _FaqTile(question: faq.q, answer: faq.a)),

            const SizedBox(height: 28),

            // ── Contact Us ──────────────────────────────────────────────────
            _sectionTitle('Contact Us'),
            const SizedBox(height: 12),
            _ContactCard(
              icon: Icons.email_outlined,
              title: 'Email Support',
              subtitle: 'sonykhan1121@gmail.com',
              onTap: () => _launch('mailto:sonykhan1121@gmail.com'),
            ),


            const SizedBox(height: 28),

            // // ── Privacy Policy ──────────────────────────────────────────────
            // _sectionTitle('Legal'),
            // const SizedBox(height: 12),
            // _ActionTile(
            //   icon: Icons.privacy_tip_outlined,
            //   title: 'Privacy Policy',
            //   onTap: () => _launch('https://moneymate.app/privacy'),
            // ),
            // const SizedBox(height: 10),
            // _ActionTile(
            //   icon: Icons.description_outlined,
            //   title: 'Terms of Service',
            //   onTap: () => _launch('https://moneymate.app/terms'),
            // ),
            //
            // const SizedBox(height: 28),

            // ── Rate & Share ────────────────────────────────────────────────
            _sectionTitle('Support Us'),
            const SizedBox(height: 12),
            _ActionTile(
              icon: Icons.star_rate_outlined,
              title: 'Rate MoneyMate',
              subtitle: 'Enjoying the app? Leave a review!',
              onTap: () => _launch('https://play.google.com/store/apps/details?id=${appInfo.packageName}'),
            ),
            const SizedBox(height: 10),
            _ActionTile(
              icon: Icons.share_outlined,
              title: 'Share MoneyMate',
              subtitle: 'Tell your friends about us',
              onTap: () =>SharePlus.instance.share(
                ShareParams(
                  text: 'Track your money with MoneyMate! Download it here: '
                      'https://play.google.com/store/apps/details?id=${appInfo.packageName}',
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      decoration: const BoxDecoration(
        border: Border(left: BorderSide(color: DColors.primary, width: 3)),
      ),
      child: Text(
        title,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
    );
  }

  static Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }
}

// ─── FAQ Tile ─────────────────────────────────────────────────────────────────
class _FaqTile extends StatelessWidget {
  final String question;
  final String answer;
  const _FaqTile({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        leading: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: DColors.primary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.question_mark_rounded, size: 16, color: DColors.primary),
        ),
        title: Text(question, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
        children: [
          Text(answer, style: TextStyle(fontSize: 13, color: Colors.grey.shade600, height: 1.6)),
        ],
      ),
    );
  }
}

// ─── Contact Card ─────────────────────────────────────────────────────────────
class _ContactCard extends StatelessWidget {
  final IconData icon;
  final String   title;
  final String   subtitle;
  final VoidCallback onTap;
  const _ContactCard({required this.icon, required this.title, required this.subtitle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: DColors.primary.withValues(alpha: 0.2)),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2)),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: DColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: DColors.primary, size: 20),
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                Text(subtitle, style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
              ],
            ),
            const Spacer(),
            Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }
}

// ─── Action Tile ──────────────────────────────────────────────────────────────
class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String   title;
  final String?  subtitle;
  final VoidCallback onTap;
  const _ActionTile({required this.icon, required this.title, this.subtitle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2)),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: DColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: DColors.primary, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  if (subtitle != null)
                    Text(subtitle!, style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }
}