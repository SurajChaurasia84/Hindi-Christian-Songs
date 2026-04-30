import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Privacy Policy', theme),
            const SizedBox(height: 8),
            const Text(
              'Hindi Christian Lyrics app built as a free application. This SERVICE is provided at no cost and is intended for use as is.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            
            _buildSectionTitle('Information Collection and Use:', theme),
            const SizedBox(height: 8),
            const Text(
              'We do not collect any personal information from users directly. However, the app uses third-party services that may collect information used to identify you, including your device\'s Advertising ID (AAID).',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            
            _buildSectionTitle('User-Submitted Content:', theme),
            const SizedBox(height: 8),
            const Text(
              'Users may submit song lyrics. We are not responsible for the accuracy or copyright ownership of user-submitted content.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            
            _buildSectionTitle('Third-party Services:', theme),
            const SizedBox(height: 8),
            const Text(
              'The app uses services such as Google Firebase (database) and Unity Ads (advertisements). These services may collect information as per their own privacy policies. We recommend reviewing them:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            _buildLink('Firebase Privacy Policy', 'https://firebase.google.com/support/privacy', theme),
            _buildLink('Unity Ads Privacy Policy', 'https://unity.com/legal/privacy-policy', theme),
            const SizedBox(height: 24),
            
            _buildSectionTitle('Copyright Policy:', theme),
            const SizedBox(height: 8),
            const Text(
              'All lyrics belong to their respective owners. If you are a copyright owner and want content removed, contact us.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            
            _buildSectionTitle('Contact Us:', theme),
            const SizedBox(height: 8),
            InkWell(
              onTap: () async {
                final Uri emailLaunchUri = Uri(
                  scheme: 'mailto',
                  path: 'jaykashyapxyz@gmail.com',
                );
                if (await canLaunchUrl(emailLaunchUri)) {
                  await launchUrl(emailLaunchUri);
                } else {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Could not open email client')),
                    );
                  }
                }
              },
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  'Email: jaykashyapxyz@gmail.com',
                  style: TextStyle(
                    fontSize: 16, 
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            
            const Text(
              'By using this app, you agree to this Privacy Policy.',
              style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.grey),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildLink(String text, String url, ThemeData theme) {
    return InkWell(
      onTap: () => launchUrl(Uri.parse(url)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Text(
          text,
          style: TextStyle(
            color: theme.colorScheme.primary,
            decoration: TextDecoration.underline,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, ThemeData theme) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: theme.colorScheme.primary,
      ),
    );
  }
}
