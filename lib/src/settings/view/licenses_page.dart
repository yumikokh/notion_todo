import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';

class LicensesPage extends ConsumerWidget {
  static const routeName = '/licenses';

  const LicensesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title:
            Text(l.licenses_page_title, style: const TextStyle(fontSize: 18)),
      ),
      body: ListView(
        children: [
          // 完了音のクレジット情報
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l.sound_credit_title,
                    style: Theme.of(context).textTheme.titleSmall),
                Text(
                  l.sound_credit_description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const Divider(),
          FutureBuilder<List<LicenseEntry>>(
            future: _loadLicenses(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error: ${snapshot.error}',
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                );
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                  child: Text(l.licenses_page_no_licenses),
                );
              }

              // パッケージ名のセットを作成
              final packageNames = _getUniquePackageNames(snapshot.data!);

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: packageNames.length,
                itemBuilder: (context, index) {
                  final packageName = packageNames.elementAt(index);
                  return ListTile(
                    title: Text(packageName),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => _PackageLicenseDetailsPage(
                            packageName: packageName,
                            licenseEntries: snapshot.data!
                                .where((entry) =>
                                    entry.packages.contains(packageName))
                                .toList(),
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Future<List<LicenseEntry>> _loadLicenses() async {
    final licenses = <LicenseEntry>[];
    await for (final license in LicenseRegistry.licenses) {
      licenses.add(license);
    }
    return licenses;
  }

  Set<String> _getUniquePackageNames(List<LicenseEntry> entries) {
    final packageNames = <String>{};
    for (final entry in entries) {
      packageNames.addAll(entry.packages);
    }
    final sortedNames = packageNames.toList()..sort();
    return sortedNames.toSet();
  }
}

class _PackageLicenseDetailsPage extends StatelessWidget {
  final String packageName;
  final List<LicenseEntry> licenseEntries;

  const _PackageLicenseDetailsPage({
    required this.packageName,
    required this.licenseEntries,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(packageName, style: const TextStyle(fontSize: 18)),
      ),
      body: ListView.builder(
        itemCount: licenseEntries.length,
        itemBuilder: (context, index) {
          final entry = licenseEntries[index];
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (entry.paragraphs.isNotEmpty &&
                    entry.paragraphs.first.text.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      entry.paragraphs.first.text,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ...entry.paragraphs.skip(1).map((paragraph) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      paragraph.text,
                      style: paragraph.indent > 0
                          ? const TextStyle(
                              fontFamily: 'monospace', fontSize: 12)
                          : null,
                    ),
                  );
                }),
              ],
            ),
          );
        },
      ),
    );
  }
}
