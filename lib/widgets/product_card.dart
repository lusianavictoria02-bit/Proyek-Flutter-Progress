import 'package:flutter/material.dart';
import '../models/models.dart';
import 'common_widgets.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;
  const ProductCard({super.key, required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(fit: StackFit.expand, children: [
                ProductImage(path: product.image),
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: cs.error, borderRadius: BorderRadius.circular(8)),
                    child: Text('-${product.discountPercent}%',
                        style: TextStyle(color: cs.onError, fontWeight: FontWeight.bold, fontSize: 12)),
                  ),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(product.name, maxLines: 1, overflow: TextOverflow.ellipsis,
                      style: tt.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                  Text('${product.shop} • ${product.distance}', maxLines: 1,
                      overflow: TextOverflow.ellipsis, style: tt.bodySmall),
                  const SizedBox(height: 4),
                  Row(children: [
                    Text(rupiah(product.price),
                        style: tt.titleSmall?.copyWith(color: cs.primary, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(rupiah(product.originalPrice),
                          overflow: TextOverflow.ellipsis,
                          style: tt.bodySmall?.copyWith(decoration: TextDecoration.lineThrough)),
                    ),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
