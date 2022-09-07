import 'package:flutter/material.dart';
import 'package:fundpad/model/faq.dart';
import 'package:fundpad/utils/util.dart';
import 'package:fundpad/widget/button_circle.dart';

class NewsView extends StatelessWidget {
  const NewsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Faq>>(
        future: Util.getNews(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Faq> faqs = snapshot.data!;

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: faqs.length,
              itemBuilder: (context, index) {
                Faq faq = faqs[index];

                return ListTile(
                  leading: const ButtonCircle(
                    padding: 8,
                    child: Icon(
                      Icons.newspaper_outlined,
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
