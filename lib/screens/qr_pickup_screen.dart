import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../models/models.dart';
import '../widgets/common_widgets.dart';

class QrPickupScreen extends StatelessWidget {
  final String orderCode, shop, pickupTime;
  final int total;
  const QrPickupScreen({
    super.key,
    required this.orderCode,
    required this.shop,
    required this.pickupTime,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Bukti Pickup')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              Icon(Icons.check_circle, size: 56, color: cs.primary),
              const SizedBox(height: 8),
              Text('Pembayaran Berhasil', style: tt.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
              const Text('Tunjukkan QR ini ke penjual saat mengambil makanan'),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(children: [
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(8),
                      child: QrImageView(data: orderCode, version: QrVersions.auto, size: 200),
                    ),
                    const SizedBox(height: 12),
                    Text(orderCode, style: tt.titleLarge?.copyWith(letterSpacing: 2, fontWeight: FontWeight.bold)),
                    const Divider(height: 28),
                    InfoRow(icon: Icons.store, text: shop),
                    InfoRow(icon: Icons.schedule, text: 'Pickup $pickupTime'),
                    InfoRow(icon: Icons.payments, text: 'Total ${rupiah(total)}'),
                  ]),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                  label: 'Kembali ke Beranda',
                  icon: Icons.home,
                  onPressed: () => Navigator.popUntil(context, (r) => r.isFirst),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
