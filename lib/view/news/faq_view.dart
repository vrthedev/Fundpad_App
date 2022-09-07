import 'package:flutter/material.dart';
import 'package:fundpad/model/faq.dart';
import 'package:fundpad/utils/const.dart';
import 'package:fundpad/utils/util.dart';
import 'package:fundpad/widget/button_circle.dart';

class FaqView extends StatelessWidget {
  const FaqView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Faq>>(
        future: Util.getFaq(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Faq> faqs = snapshot.data!;

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: faqs.length,
              itemBuilder: (context, index) {
                Faq faq = faqs[index];

                return ListTile(
                  leading: ButtonCircle(
                    gradient: const [COLOR.ORANGE_LIGHT, COLOR.ORANGE_DARK],
                    shadow: COLOR.ORANGE_DARK.withOpacity(0.25),
                    padding: 8,
                    child: const Icon(
                      Icons.help_outline,
                      color: Colors.white,
                      size: 12,
                    ),
                  ),
                  title: Text(
                    faq.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(faq.content),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Container();
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
