import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:meal_muse/src/core/constants/spacing.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  final String githubUrl = "https://github.com/Pak-Man926";
  final String discordUrl = "https://discordapp.com/users/1034143939906773054";

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    final logger = Logger();

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      logger.e("Could not launch $urlString");
      throw 'Could not launch $urlString';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts", style: theme.textTheme.titleLarge),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: .start,
        crossAxisAlignment: .start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                color: theme.colorScheme.onSurfaceVariant.withOpacity(0.3),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: theme.colorScheme.onSurface.withOpacity(0.1),
                ),
              ),
              child: Column(
                mainAxisAlignment: .start,
                crossAxisAlignment: .start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: .start,
                      crossAxisAlignment: .start,
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundImage: AssetImage(
                            "assets/IMG_20200629_112219.jpg",
                          ),
                        ),
                        Spacing.horizontal(10),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: .start,
                            crossAxisAlignment: .start,
                            children: [
                              Text(
                                "David Kamau",
                                style: theme.textTheme.titleLarge!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacing.vertical(5),
                              Text(
                                "App Developer || Fullstack Software Developer",
                                style: theme.textTheme.bodyMedium!.copyWith(
                                  color: theme.colorScheme.primary,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacing.vertical(5),
                  Divider(
                    color: theme.colorScheme.onSurface.withOpacity(0.1),
                    thickness: 2,
                  ),
                  ListTile(
                    title: Text("Github", style: theme.textTheme.bodyLarge),
                    trailing: Icon(
                      PhosphorIcons.githubLogo,
                      size: 28.0,
                      color: theme.colorScheme.primary,
                    ),
                    onTap: () {
                      // Handle Github link tap
                      _launchUrl(githubUrl);
                    },
                  ),
                  Spacing.vertical(5),
                  Divider(
                    color: theme.colorScheme.onSurface.withOpacity(0.1),
                    thickness: 2,
                  ),
                  ListTile(
                    title: Text("Discord", style: theme.textTheme.bodyLarge),
                    trailing: Icon(
                      Icons.discord_rounded,
                      color: theme.colorScheme.primary,
                    ),
                    onTap: () {
                      // Handle Discord link tap
                      _launchUrl(discordUrl);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
