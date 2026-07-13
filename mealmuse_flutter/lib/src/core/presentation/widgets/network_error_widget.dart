import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_muse/src/core/constants/constants.dart';
import 'package:meal_muse/src/core/network/network_provider.dart';

class NetworkErrorWidget extends StatelessWidget {
  const NetworkErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(48),
        color: Theme.of(context).colorScheme.surface,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Here I am using an svg icon
            // SvgPicture.asset(
            //   'assets/icons/network.svg',
            //   width: 200,
            //   height: 200,
            //   color: Colors.red[200],
            // ),
            Icon(
              Icons.wifi_off,
              size: 96,
              color: Theme.of(context).colorScheme.error,
            ),
            mediumSpaceSize,
            Text(
              'Internet connection lost!',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            smallSpaceSize,
            Text(
              'Check your connection and try again.',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            largeSpaceSize,
            Consumer(
              builder: (context, ref, child) {
                return TextButton(
                  onPressed: () {
                    // Refresh the connectivity provider and use the returned AsyncValue
                    final refreshed = ref.refresh(connectivityStatusProvider);
                    refreshed.whenData((status) {
                      final message = status == ConnectivityStatus.isConnected
                          ? 'Back online'
                          : 'Still offline';
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: theme.colorScheme.primary,
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.only(
                            bottom: MediaQuery.sizeOf(context).height - 150,
                            left: 20,
                            right: 20,
                          ),
                          dismissDirection: DismissDirection.up,
                          content: Text(message),
                        ),
                      );
                    });
                  },
                  child: Text('Retry'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
