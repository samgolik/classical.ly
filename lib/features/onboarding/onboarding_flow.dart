import 'package:flutter/material.dart';
import '../../data/profile_store.dart';
import '../../theme/app_theme.dart';

class OnboardingFlow extends StatefulWidget {
  const OnboardingFlow({required this.onComplete, super.key});
  final VoidCallback onComplete;
  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  final controller = PageController();
  final name = TextEditingController();
  final instrument = TextEditingController();
  int page = 0;
  @override void dispose() { controller.dispose(); name.dispose(); instrument.dispose(); super.dispose(); }
  Future<void> finish() async {
    if (name.text.trim().isEmpty || instrument.text.trim().isEmpty) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Tell us your name and primary instrument.'))); return; }
    await ProfileStore.instance.complete(name: name.text, instrument: instrument.text);
    widget.onComplete();
  }
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(children: [
              Align(alignment: Alignment.centerLeft, child: Text('classical.ly', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppTheme.gold))),
              const Spacer(),
              Expanded(flex: 6, child: PageView(controller: controller, onPageChanged: (value) => setState(() => page = value), children: [const _Welcome(), _ProfileSetup(name: name, instrument: instrument)])),
              Row(children: [
                ...List.generate(2, (index) => AnimatedContainer(duration: const Duration(milliseconds: 180), margin: const EdgeInsets.only(right: 7), height: 6, width: page == index ? 28 : 6, decoration: BoxDecoration(color: page == index ? AppTheme.gold : AppTheme.cream.withValues(alpha: .2), borderRadius: BorderRadius.circular(10)))),
              ]),
              const Spacer(),
              FilledButton(onPressed: page == 0 ? () => controller.nextPage(duration: const Duration(milliseconds: 280), curve: Curves.easeOutCubic) : finish, child: Text(page == 0 ? 'Begin your archive' : 'Create my profile')),
              const SizedBox(height: 12),
            ]),
          ),
        ),
      );
}

class _Welcome extends StatelessWidget { const _Welcome(); @override Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Spacer(), Container(width: 76, height: 76, alignment: Alignment.center, decoration: BoxDecoration(color: AppTheme.gold.withValues(alpha: .15), borderRadius: BorderRadius.circular(24)), child: const Icon(Icons.auto_stories_rounded, color: AppTheme.gold, size: 38)), const SizedBox(height: 28), Text('Remember every\npiece that shaped you.', style: Theme.of(context).textTheme.displaySmall), const SizedBox(height: 16), const Text('classical.ly is your living repertoire: the performances, ensembles, and musical memories that make up your story.', style: TextStyle(color: AppTheme.muted, height: 1.5, fontSize: 16)), const Spacer(), ]); }
class _ProfileSetup extends StatelessWidget { const _ProfileSetup({required this.name, required this.instrument}); final TextEditingController name, instrument; @override Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Spacer(), const Icon(Icons.person_outline_rounded, color: AppTheme.gold, size: 42), const SizedBox(height: 22), Text('Make it yours.', style: Theme.of(context).textTheme.displaySmall), const SizedBox(height: 12), const Text('A few details help make your musical archive feel like home.', style: TextStyle(color: AppTheme.muted, height: 1.5, fontSize: 16)), const SizedBox(height: 30), TextField(controller: name, textCapitalization: TextCapitalization.words, decoration: const InputDecoration(labelText: 'Your name')), const SizedBox(height: 12), TextField(controller: instrument, textCapitalization: TextCapitalization.words, decoration: const InputDecoration(labelText: 'Primary instrument')), const Spacer(), ]); }
