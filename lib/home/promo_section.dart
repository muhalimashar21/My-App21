import 'package:flutter/material.dart';
import 'package:my_solonet_app/promo/detail_promo.dart';

class PromoSection extends StatelessWidget {
  final List<dynamic> banners;
  final PageController pageController;

  final int currentPage;
  final Function(int) onPageChanged;

  const PromoSection({
    super.key,
    required this.banners,
    required this.pageController,
    required this.currentPage,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 165,
      child: banners.isNotEmpty
          ? PageView.builder(
              controller: pageController,
              itemCount: banners.length,
              onPageChanged: onPageChanged,
              itemBuilder: (context, index) {
                final banner = banners[index];
                final imagePath = banner['gambar'];

                return GestureDetector(
                  onTap: () {
                    print('Banner $index clicked');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPromo(
                          imagePath: imagePath,
                          title: banner['judul'],
                          description: banner['deskripsi'],
                          syaratKetentuan:
                              (banner['syarat_ketentuan'] as List<dynamic>)
                                  .join('\n,'),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
