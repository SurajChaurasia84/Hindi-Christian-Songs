import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('About This App'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              theme,
              "Welcome to Hindi Christian Songs, your digital collection of Hindi Christian song lyrics, worship songs, praise hymns, and fellowship music.",
            ),
            const SizedBox(height: 16),
            _buildSection(
              theme,
              "This application is specially created for Hindi-speaking believers, churches, worship teams, youth fellowships, prayer groups, and anyone who loves to sing and meditate on Christian songs.",
            ),
            const SizedBox(height: 16),
            _buildSection(
              theme,
              "Our goal is to make Hindi Christian lyrics easily accessible in one place so that users can:",
            ),
            const SizedBox(height: 12),
            _buildBullet(theme, "Read worship songs anytime,"),
            _buildBullet(theme, "Use lyrics during church fellowship,"),
            _buildBullet(theme, "Practice choir songs,"),
            _buildBullet(theme, "Learn new Christian hymns,"),
            _buildBullet(
              theme,
              "Replace traditional handwritten song notebooks with a simple digital songbook.",
            ),
            const SizedBox(height: 16),
            _buildSection(
              theme,
              "We understand that many believers still depend on paper song copies or handwritten notes during worship. This app is designed to provide a convenient, searchable, and mobile-friendly alternative for daily worship and ministry use.",
            ),
            const SizedBox(height: 32),

            _buildHeading(theme, "Features of This App"),
            const SizedBox(height: 12),
            _buildBullet(theme, "Large collection of Hindi Christian song lyrics"),
            _buildBullet(theme, "Easy search by song title"),
            _buildBullet(theme, "Simple and clean reading interface"),
            _buildBullet(theme, "Favorites / bookmark support"),
            _buildBullet(theme, "Regular song updates"),
            _buildBullet(theme, "Lightweight and easy to use"),
            const SizedBox(height: 32),

            _buildHeading(theme, "Our Mission"),
            const SizedBox(height: 12),
            _buildSection(
              theme,
              "Our mission is to spread the message of praise, worship, and faith through music by making Hindi Christian songs available to everyone in a simple digital format.",
            ),
            const SizedBox(height: 16),
            _buildSection(
              theme,
              "We pray that this app becomes a blessing for churches, families, ministries, and believers everywhere.",
            ),
            const SizedBox(height: 16),
            _buildSection(
              theme,
              "Thank you for using Hindi Christian Songs.\n\nBe blessed and keep worshipping!",
            ),
            const SizedBox(height: 32),

            _buildHeading(theme, "Contact Us"),
            const SizedBox(height: 12),
            _buildSection(
              theme,
              "For suggestions, corrections, or support, feel free to contact us:",
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: () async {
                final Uri emailLaunchUri = Uri(
                  scheme: 'mailto',
                  path: 'jaykashyapxy@gmail.com',
                );
                if (await canLaunchUrl(emailLaunchUri)) {
                  await launchUrl(emailLaunchUri);
                } else {
                  // Fallback if no email client is available
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Could not open email client')),
                    );
                  }
                }
              },
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Icon(Icons.email_rounded, color: theme.colorScheme.primary),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "jaykashyapxy@gmail.com",
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildHeading(ThemeData theme, String text) {
    return Text(
      text,
      style: theme.textTheme.titleLarge?.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSection(ThemeData theme, String text) {
    return Text(
      text,
      style: theme.textTheme.bodyMedium?.copyWith(height: 1.6),
    );
  }

  Widget _buildBullet(ThemeData theme, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "• ",
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodyMedium?.copyWith(height: 1.6),
            ),
          ),
        ],
      ),
    );
  }
}
