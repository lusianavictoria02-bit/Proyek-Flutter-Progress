import 'package:flutter/material.dart';
import '../widgets/common_widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _soon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Segera hadir')));
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final menus = [
      (Icons.receipt_long, 'Riwayat Pesanan'),
      (Icons.location_on_outlined, 'Alamat Saya'),
      (Icons.notifications_outlined, 'Notifikasi'),
      (Icons.help_outline, 'Bantuan'),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: ListView(padding: const EdgeInsets.all(16), children: [
            Column(children: [
              CircleAvatar(
                radius: 44,
                backgroundColor: cs.primaryContainer,
                child: Icon(Icons.person, size: 48, color: cs.onPrimaryContainer),
              ),
              const SizedBox(height: 12),
              Text('Nama Pengguna', style: tt.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
              const Text('pengguna@email.com'),
            ]),
            const SizedBox(height: 20),
            const Row(children: [
              Expanded(child: StatTile(icon: Icons.restaurant, value: '12', label: 'Makanan diselamatkan')),
              SizedBox(width: 12),
              Expanded(child: StatTile(icon: Icons.savings, value: 'Rp180.000', label: 'Total hemat')),
            ]),
            const SizedBox(height: 12),
            Card(
              child: Column(
                children: [
                  for (final m in menus)
                    ListTile(
                      leading: Icon(m.$1),
                      title: Text(m.$2),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => _soon(context),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () => _soon(context),
              icon: const Icon(Icons.logout),
              label: const Text('Keluar'),
            ),
          ]),
        ),
      ),
    );
  }
}
