import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/glass_card.dart';

class DepositPanel extends StatelessWidget {
  const DepositPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xAA081A46), Color(0xDD0B2B5A)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 0.62,
        minChildSize: 0.45,
        maxChildSize: 0.92,
        builder: (context, scrollController) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: const BoxDecoration(
              color: Color(0xFF0B1B42),
              borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            ),
            child: ListView(
              controller: scrollController,
              children: [
                Center(
                  child: Container(
                    width: 64,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'مناف احمد صالح العامري',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'حساب الإيداع المميز',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 24),
                _buildBankCard(
                  title: 'العمقي',
                  subtitle: 'Al-Amqi',
                  accountNumber: '012-345-6789',
                  startColor: const Color(0xFF0D4D1D),
                  endColor: const Color(0xFF0B8A2E),
                ),
                const SizedBox(height: 16),
                _buildBankCard(
                  title: 'الكريمي',
                  subtitle: 'Kuraimi',
                  accountNumber: '987-654-3210',
                  startColor: const Color(0xFF0097A7),
                  endColor: const Color(0xFF00B8D4),
                ),
                const SizedBox(height: 16),
                _buildBankCard(
                  title: 'القطيبي',
                  subtitle: 'Al-Qutaibi',
                  accountNumber: '564-738-2910',
                  startColor: const Color(0xFF4CAF50),
                  endColor: const Color(0xFF8BC34A),
                ),
                const SizedBox(height: 16),
                _buildBankCard(
                  title: 'البسيري',
                  subtitle: 'Al-Busiri',
                  accountNumber: '840-273-1569',
                  startColor: const Color(0xFF1E88E5),
                  endColor: const Color(0xFFFB8C00),
                ),
                const SizedBox(height: 24),
                GlassCard(
                  padding: const EdgeInsets.all(18),
                  backgroundColor: const Color.fromRGBO(255, 255, 255, 0.08),
                  borderColor: Colors.white24,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'تعليمات الإيداع',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'اختر البنك ثم انسخ رقم الحساب وابدأ التحويل مباشرة. هذه الشاشة تعرض معلومات رسمية وأنيقة فقط.',
                        style: GoogleFonts.inter(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBankCard({
    required String title,
    required String subtitle,
    required String accountNumber,
    required Color startColor,
    required Color endColor,
  }) {
    return GlassCard(
      borderRadius: BorderRadius.circular(22),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
      backgroundColor: Colors.white.withOpacity(0.08),
      borderColor: Colors.white24,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [startColor, endColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(22),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: GoogleFonts.inter(
                color: Colors.white70,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'رقم الحساب',
              style: GoogleFonts.inter(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              accountNumber,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
