import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import '../../../l10n/app_localizations.dart';

import '../../notion/model/task_database.dart';
import '../../subscription/model/subscription_model.dart';
import '../task_database/task_database_viewmodel.dart';
import 'language_settings_page.dart';
import 'notification_settings_page.dart';
import 'notion_settings_page.dart';
import '../settings_viewmodel.dart';
import '../../common/analytics/analytics_service.dart';
import '../../common/app_version/app_version_viewmodel.dart';
import '../../subscription/view/paywall_sheet.dart';
import '../../subscription/subscription_viewmodel.dart';
import 'appearance_settings_page.dart';
import 'behavior_settings_page.dart';
import 'licenses_page.dart';
import 'widget/subscription_banner.dart';

class SettingsPage extends ConsumerWidget {
  static const routeName = '/settings';

  static const TextStyle _supportFontStyle = TextStyle(fontSize: 13);

  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final database = ref.watch(taskDatabaseViewModelProvider).valueOrNull;
    final analytics = ref.read(analyticsServiceProvider);
    final appVersionViewModel = ref.read(appVersionViewModelProvider);
    final subscriptionStatus =
        ref.watch(subscriptionViewModelProvider).valueOrNull;
    final subscriptionViewModel =
        ref.read(subscriptionViewModelProvider.notifier);

    final l = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title:
            Text(l.settings_view_title, style: const TextStyle(fontSize: 18)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ListView(
          children: [
            if (subscriptionViewModel.shouldShowSubscriptionBanner) ...[
              SubscriptionBanner(
                subscriptionStatus: subscriptionStatus ??
                    SubscriptionStatus(
                      isActive: false,
                      activeType: SubscriptionType.none,
                    ),
                onTap: () {
                  analytics.logScreenView(screenName: 'Paywall');
                  PaywallSheet.show(context);
                },
              ),
              const SizedBox(height: 16),
            ],
            _buildPlanListTile(
                context, subscriptionStatus, database, analytics, l),
            const SizedBox(height: 16),
            _buildSection(
              context,
              title: l.settings_view_app_settings_title,
              children: [
                ListTile(
                  title: Text(l.language_settings_title),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(ref.watch(settingsViewModelProvider).languageName(l),
                          style: const TextStyle(fontSize: 14)),
                      const SizedBox(width: 8),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                  onTap: () {
                    analytics.logScreenView(screenName: 'LanguageSettings');
                    Navigator.of(context)
                        .pushNamed(LanguageSettingsPage.routeName);
                  },
                ),
                ListTile(
                  title: Text(l.appearance_settings_title),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    analytics.logScreenView(screenName: 'AppearanceSettings');
                    Navigator.of(context)
                        .pushNamed(AppearanceSettingsPage.routeName);
                  },
                ),
                ListTile(
                  title: Text(l.notifications),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    analytics.logScreenView(screenName: 'NotificationSettings');
                    Navigator.of(context)
                        .pushNamed(NotificationSettingsPage.routeName);
                  },
                ),
                ListTile(
                  title: Text(l.behavior_settings_title),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    analytics.logScreenView(screenName: 'BehaviorSettings');
                    Navigator.of(context)
                        .pushNamed(BehaviorSettingsPage.routeName);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              title: l.settings_view_support_title,
              children: [
                ListTile(
                  dense: true,
                  title: Text(l.settings_view_support_faq_title,
                      style: _supportFontStyle),
                  trailing: const Icon(Icons.question_mark_rounded, size: 16),
                  onTap: () async {
                    const url =
                        'https://yumikokh.notion.site/Tanzaku-Todo-11f54c37a54c800da12cf5162f5beada';
                    if (await canLaunchUrl(Uri.parse(url))) {
                      await launchUrl(Uri.parse(url));
                      analytics.logScreenView(screenName: 'FAQ');
                    }
                  },
                ),
                ListTile(
                  dense: true,
                  title: Text(l.settings_view_support_release_notes_title,
                      style: _supportFontStyle),
                  trailing: const Icon(Icons.new_releases_outlined, size: 16),
                  onTap: () async {
                    const url =
                        'https://yumikokh.notion.site/Release-Note-18154c37a54c807b8ac6ef6612524378';
                    if (await canLaunchUrl(Uri.parse(url))) {
                      await launchUrl(Uri.parse(url));
                      analytics.logScreenView(screenName: 'ReleaseNotes');
                    }
                  },
                ),
                ListTile(
                  dense: true,
                  title: Text(l.settings_view_support_review_title,
                      style: _supportFontStyle),
                  trailing: const Icon(Icons.favorite_rounded, size: 16),
                  onTap: () async {
                    const url =
                        'https://apps.apple.com/jp/app/tanzaku-todo-for-notion/id6738761486';
                    if (await canLaunchUrl(Uri.parse(url))) {
                      await launchUrl(Uri.parse(url),
                          mode: LaunchMode.externalApplication);
                      analytics.logScreenView(screenName: 'Review');
                    }
                  },
                ),
                ListTile(
                  dense: true,
                  title: Text(l.settings_view_support_feedback_title,
                      style: _supportFontStyle),
                  trailing: const Icon(Icons.feedback_outlined, size: 16),
                  onTap: () async {
                    const url =
                        'https://docs.google.com/forms/d/e/1FAIpQLSfIdMsEJVzbWHdxdvNzr_-OUPEVqe3AMOmafCYctaa7hzcQpQ/viewform';
                    if (await canLaunchUrl(Uri.parse(url))) {
                      await launchUrl(Uri.parse(url));
                      analytics.logScreenView(screenName: 'Feedback');
                    }
                  },
                ),
                ListTile(
                  dense: true,
                  title: Text(l.settings_view_support_privacy_policy_title,
                      style: _supportFontStyle),
                  trailing: const Icon(Icons.privacy_tip_outlined, size: 16),
                  onTap: () async {
                    const url =
                        'https://yumikokh.notion.site/Privacy-Policy-14b54c37a54c80e1b288c0097bb6c7bd';
                    if (await canLaunchUrl(Uri.parse(url))) {
                      await launchUrl(Uri.parse(url));
                      analytics.logScreenView(screenName: 'PrivacyPolicy');
                    }
                  },
                ),
                ListTile(
                  dense: true,
                  title: Text(l.licenses_page_title, style: _supportFontStyle),
                  trailing: const Icon(Icons.description_outlined, size: 16),
                  onTap: () {
                    analytics.logScreenView(screenName: 'Licenses');
                    Navigator.of(context).pushNamed(LicensesPage.routeName);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () async {
                final version = await appVersionViewModel.getCurrentVersion();
                if (!context.mounted) return;
                Clipboard.setData(ClipboardData(text: version));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(l.settings_view_version_copy),
                    duration: const Duration(seconds: 2),
                  ),
                );
                analytics.logSettingsChanged(
                  settingName: 'copy_version',
                  value: version,
                );
              },
              child: ListTile(
                dense: true,
                title: Text(l.settings_view_version_title,
                    style: _supportFontStyle),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FutureBuilder<String>(
                      future: appVersionViewModel.getCurrentVersion(),
                      builder: (context, snapshot) {
                        final version = snapshot.data ?? '';
                        return Text(version,
                            style: const TextStyle(fontSize: 14));
                      },
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.copy, size: 14),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanListTile(
      BuildContext context,
      SubscriptionStatus? subscriptionStatus,
      TaskDatabase? database,
      AnalyticsService analytics,
      AppLocalizations l) {
    String planText = l.free_plan;
    if (subscriptionStatus?.isActive == true) {
      planText = l.premium_plan;
    }

    return _buildSection(
      context,
      title: l.account_settings_title,
      children: [
        ListTile(
          title: Text(l.plan_title),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(planText, style: const TextStyle(fontSize: 14)),
              const SizedBox(width: 8),
              const Icon(Icons.chevron_right),
            ],
          ),
          onTap: () {
            analytics.logScreenView(screenName: 'Paywall');
            PaywallSheet.show(context);
          },
        ),
        ListTile(
          title: Text(l.settings_view_notion_settings_title),
          subtitle: database == null
              ? Row(
                  children: [
                    Icon(Icons.warning_rounded,
                        size: 16, color: Theme.of(context).colorScheme.error),
                    const SizedBox(width: 8),
                    Text(l.settings_view_notion_settings_description),
                  ],
                )
              : null,
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(database != null ? database.name : '',
                  style: const TextStyle(fontSize: 14)),
              const SizedBox(width: 8),
              const Icon(Icons.chevron_right),
            ],
          ),
          onTap: () {
            analytics.logScreenView(screenName: 'NotionSettings');
            Navigator.of(context).pushNamed(NotionSettingsPage.routeName);
          },
        ),
      ],
    );
  }

  Widget _buildSection(BuildContext context,
      {required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        ...children,
      ],
    );
  }
}
