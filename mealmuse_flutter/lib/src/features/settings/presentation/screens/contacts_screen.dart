import 'package:flutter/material.dart';
import 'package:meal_muse/src/core/constants/spacing.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

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
                              Text("David Kamau", style: theme.textTheme.titleLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                              )),
                              Spacing.vertical(5),
                              Text("App Developer || Fullstack Software Developer", style: theme.textTheme.bodyMedium!.copyWith(
                                color: theme.colorScheme.primary,
                                fontSize: 12
                              )),
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
                    trailing: Icon(Icons.outbond_outlined, color: theme.colorScheme.primary),
                    onTap: () {
                      // Handle Github link tap
                    },
                  ),
                  Spacing.vertical(5),
                  Divider(
                    color: theme.colorScheme.onSurface.withOpacity(0.1),
                    thickness: 2,
                  ),
                  ListTile(
                    title: Text("Discord", style: theme.textTheme.bodyLarge),
                    trailing: Icon(Icons.discord_rounded, color: theme.colorScheme.primary),
                    onTap: () {
                      // Handle Discord link tap
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
