import 'package:flutter/material.dart';
import 'package:jrrk/core/eco_background.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: EcoScanTheme.mistTeal,
              child: Icon(Icons.support_agent_rounded, size: 18, color: EcoScanTheme.charcoal),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Customer Service', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                Text('Online', style: TextStyle(fontSize: 11, color: EcoScanTheme.slate)),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () => showPlaceholderDialog(context, 'Voice call'), icon: const Icon(Icons.call_outlined)),
          IconButton(onPressed: () => showPlaceholderDialog(context, 'Video call'), icon: const Icon(Icons.videocam_outlined)),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _ChatBubble(text: 'Hi there! How can I help you today?', isIncoming: true),
                    const SizedBox(height: 12),
                    const _ChatBubble(text: 'I need help with my account setup.', isIncoming: false),
                    const SizedBox(height: 12),
                    const _ChatBubble(text: 'Absolutely. We can review your onboarding status and guide the next step.', isIncoming: true),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 14),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: EcoScanTheme.border)),
              ),
              child: Row(
                children: [
                  IconButton(onPressed: () => showPlaceholderDialog(context, 'Voice note'), icon: const Icon(Icons.mic_none_rounded)),
                  IconButton(onPressed: () => showPlaceholderDialog(context, 'Emoji picker'), icon: const Icon(Icons.emoji_emotions_outlined)),
                  IconButton(onPressed: () => showPlaceholderDialog(context, 'Attachment upload'), icon: const Icon(Icons.attach_file_rounded)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      height: 46,
                      decoration: BoxDecoration(
                        color: EcoScanTheme.slateWhite,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: EcoScanTheme.border),
                      ),
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: const Text('Type a message', style: TextStyle(color: EcoScanTheme.slate)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: EcoScanTheme.charcoal,
                    child: IconButton(
                      onPressed: () => showPlaceholderDialog(context, 'Send message'),
                      icon: const Icon(Icons.send_rounded, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  const _ChatBubble({required this.text, required this.isIncoming});

  final String text;
  final bool isIncoming;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isIncoming ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 280),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: isIncoming ? const Color(0xFFE5E7EB) : EcoScanTheme.charcoal,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isIncoming ? EcoScanTheme.charcoal : Colors.white,
            fontSize: 14,
            height: 1.4,
          ),
        ),
      ),
    );
  }
}
