import 'package:flutter/material.dart';
import 'package:scribe/decorators/colors/app_colors.dart';
import 'package:scribe/screens/side_drawer/about_scribe/about.dart';
import 'package:scribe/screens/side_drawer/about_scribe/privacy_policy.dart';

class ScreenAboutWidget extends StatelessWidget {
  const ScreenAboutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22, top: 17),
      child: Column(
        children: [
          InkWell(
            child: SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.info_outline_rounded,
                      color: navyBlueExtraLightColor, size: 22),
                  const SizedBox(width: 6),
                  Text(
                    'About us',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: navyBlueDeepLightColor, fontSize: 15),
                  )
                ],
              ),
            ),
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ScreenAbout())),
          ),
          const SizedBox(height: 15),
          InkWell(
            child: SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.lock_outline_rounded,
                      color: navyBlueExtraLightColor, size: 22),
                  const SizedBox(width: 6),
                  Text(
                    'Privacy policy',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: navyBlueDeepLightColor, fontSize: 15),
                  )
                ],
              ),
            ),
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ScreenPrivacy())),
          ),
        ],
      ),
    );
  }
}
