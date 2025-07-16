import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tanzaku_todo/generated/app_localizations.dart';

import '../../toggl/toggl_viewmodel.dart';
import '../../toggl/toggl_api_service.dart';
import '../widgets/settings_list_tile.dart';

class TogglSettingsPage extends HookConsumerWidget {
  const TogglSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final togglState = ref.watch(togglViewModelProvider);
    final togglViewModel = ref.read(togglViewModelProvider.notifier);
    
    final apiTokenController = useTextEditingController();
    final showApiToken = useState(false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Toggl Track 設定'),
      ),
      body: togglState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text('エラーが発生しました: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.refresh(togglViewModelProvider),
                child: const Text('再試行'),
              ),
            ],
          ),
        ),
        data: (state) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Toggl連携の有効/無効
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Toggl Track 連携',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      const Text('タスクから直接Toggl Trackのタイマーを開始できます'),
                      const SizedBox(height: 16),
                      SwitchListTile(
                        title: const Text('Toggl連携を有効にする'),
                        value: state.enabled,
                        onChanged: (enabled) => togglViewModel.setEnabled(enabled),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 16),

              // API設定
              if (state.enabled) ...[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'API設定',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        
                        // APIトークン入力
                        TextField(
                          controller: apiTokenController,
                          obscureText: !showApiToken.value,
                          decoration: InputDecoration(
                            labelText: 'API Token',
                            hintText: state.apiToken ?? 'API Tokenを入力してください',
                            border: const OutlineInputBorder(),
                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    showApiToken.value ? Icons.visibility_off : Icons.visibility,
                                  ),
                                  onPressed: () => showApiToken.value = !showApiToken.value,
                                ),
                                IconButton(
                                  icon: const Icon(Icons.save),
                                  onPressed: () async {
                                    if (apiTokenController.text.isNotEmpty) {
                                      await togglViewModel.saveApiToken(apiTokenController.text);
                                      apiTokenController.clear();
                                      if (context.mounted) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('API Tokenを保存しました')),
                                        );
                                      }
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // API Token取得方法の説明
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surfaceVariant,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'API Tokenの取得方法：',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              const Text('1. Toggl Track (track.toggl.com) にログイン'),
                              const Text('2. プロフィール設定を開く'),
                              const Text('3. API Token欄からトークンをコピー'),
                              const SizedBox(height: 8),
                              TextButton(
                                onPressed: () {
                                  // TODO: URL Launcherで開く
                                },
                                child: const Text('Toggl Track を開く'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),

                // ワークスペース設定
                if (state.apiToken != null) ...[
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'ワークスペース',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const Spacer(),
                              IconButton(
                                icon: const Icon(Icons.refresh),
                                onPressed: () => togglViewModel.loadWorkspaces(),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          
                          if (state.workspaces.isEmpty)
                            const Text('ワークスペースを読み込んでください')
                          else
                            DropdownButtonFormField<int>(
                              value: state.workspaceId,
                              decoration: const InputDecoration(
                                labelText: 'ワークスペースを選択',
                                border: OutlineInputBorder(),
                              ),
                              items: state.workspaces.map((workspace) {
                                return DropdownMenuItem(
                                  value: workspace.id,
                                  child: Text(workspace.name),
                                );
                              }).toList(),
                              onChanged: (workspaceId) {
                                if (workspaceId != null) {
                                  togglViewModel.saveWorkspaceId(workspaceId);
                                }
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),

                  // プロジェクト設定
                  if (state.workspaceId != null) ...[
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'プロジェクト（任意）',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                const Spacer(),
                                IconButton(
                                  icon: const Icon(Icons.refresh),
                                  onPressed: () => togglViewModel.loadProjects(),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            
                            if (state.projects.isEmpty)
                              const Text('プロジェクトを読み込んでください（またはプロジェクトがありません）')
                            else
                              DropdownButtonFormField<int?>(
                                value: state.projectId,
                                decoration: const InputDecoration(
                                  labelText: 'プロジェクトを選択（任意）',
                                  border: OutlineInputBorder(),
                                ),
                                items: [
                                  const DropdownMenuItem<int?>(
                                    value: null,
                                    child: Text('プロジェクトなし'),
                                  ),
                                  ...state.projects.map((project) {
                                    return DropdownMenuItem(
                                      value: project.id,
                                      child: Text(project.name),
                                    );
                                  }),
                                ],
                                onChanged: (projectId) {
                                  togglViewModel.saveProjectId(projectId);
                                },
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ],

              // 設定状況の表示
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '設定状況',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      _buildStatusItem(
                        context,
                        '連携有効',
                        state.enabled,
                      ),
                      _buildStatusItem(
                        context,
                        'API Token',
                        state.apiToken != null && state.apiToken!.isNotEmpty,
                      ),
                      _buildStatusItem(
                        context,
                        'ワークスペース',
                        state.workspaceId != null,
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: state.isConfigured 
                              ? Colors.green.withOpacity(0.1)
                              : Colors.orange.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              state.isConfigured ? Icons.check_circle : Icons.warning,
                              color: state.isConfigured ? Colors.green : Colors.orange,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              state.isConfigured 
                                  ? 'Toggl連携の設定が完了しています'
                                  : 'Toggl連携を使用するには追加の設定が必要です',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusItem(BuildContext context, String label, bool isOk) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            isOk ? Icons.check_circle : Icons.cancel,
            color: isOk ? Colors.green : Colors.red,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }
}