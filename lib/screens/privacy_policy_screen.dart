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
              'We do not collect any personal information from users. However, the app may use third-party services like Firebase and Google AdMob which may collect data used to identify you.',
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
              'The app may use services such as Google Firebase and Google AdMob. These services may collect information as per their own privacy policies.',
              style: TextStyle(fontSize: 16),
            ),
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
