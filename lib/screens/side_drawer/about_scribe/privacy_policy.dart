import 'package:flutter/material.dart';

class ScreenPrivacy extends StatelessWidget {
  const ScreenPrivacy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy policy'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Privacy policy',
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 24)),
              const SizedBox(height: 16),
              Text(
                  'We value the trust you place in us and recognize the importance of secure transactions and information privacy. This Privacy Policy describes how "Scribe" (referred to as "Scribe", "we", "our", "us") collects, uses, shares or otherwise processes your personal data through the Scribe mobile application (hereinafter referred to as the "Platform").',
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 16),
              Text(
                  'While you can browse sections of the Platform without the need of sharing any information with us, certain features may require you to provide personal data. Your personal data will primarily be stored and processed in accordance with applicable laws.',
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 16),
              Text(
                  'By using this Platform, providing your information, or availing our services, you expressly agree to be bound by the terms and conditions of this Privacy Policy, the Terms of Use, and the applicable service/product terms and conditions. You also agree to be governed by the laws of your country, including but not limited to laws applicable to data protection and privacy. If you do not agree, please do not use or access our Platform.',
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 16),
              Text(
                'Collection of Your Information',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(fontSize: 19, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text(
                  'When you use our Platform, we collect and store your information which is provided by you from time to time. Once you give us your personal data, you are not anonymous to us. Where possible, we indicate which fields are required and which fields are optional. You always have the option to not provide data by choosing not to use a particular service, product, or feature on the Platform.',
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 16),
              Text(
                  'We may track your preferences and other information that you choose to provide on our Platform. We use this information to do internal research on our users\' demographics, interests, and behavior to better understand, protect, and serve our users. This information is compiled and analyzed on an aggregated basis.',
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 16),
              Text(
                  'We may collect personal data such as your name from you when you set up an account or use the Platform. Certain activities (such as receiving notifications) may require registration. We use your contact information to send you offers and updates based on your interests.',
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 16),
              Text(
                'Usage of Information',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(fontSize: 19, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text(
                  'We use personal information to provide the services you request. We use your personal information to resolve disputes, troubleshoot problems, and help promote a safe service. We also use your information to improve our services, content, and advertising; customize your experience; detect and protect us against error, fraud, and other criminal activity; enforce our terms and conditions; and as otherwise described to you at the time of collection.',
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 16),
              Text(
                'Sharing of Information',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(fontSize: 19, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text(
                  'We do not share or rent your personal information with third parties except as described in this Privacy Policy. We may share personal information with our other corporate entities and affiliates. These entities and affiliates may share such information with their affiliates, business partners, and others. Should we merge with or be acquired by another company, we will share information with them in accordance with our privacy standards.',
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 16),
              Text(
                'Security of Information',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(fontSize: 19, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text(
                  'We take adequate measures to protect the security of your personal information during transmission using secure connection protocols. We also take appropriate security measures to protect your data stored on our servers.',
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 16),
              Text(
                'Your Consent',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(fontSize: 19, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text(
                  'By using the Platform and/or by providing your information, you consent to the collection and use of the information you disclose on the Platform in accordance with this Privacy Policy.',
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 16),
              Text(
                'Contact Us',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(fontSize: 19, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text(
                  'If you have any questions about this Privacy Policy, the practices of the Platform, or your dealings with the Platform, you can contact us at:',
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 8),
              Text(
                  'Scribe Support\nEmail: support@scribeapp.com\nMobile: +91 7558022365',
                  style: Theme.of(context).textTheme.titleSmall),
            ],
          ),
        ),
      ),
    );
  }
}
