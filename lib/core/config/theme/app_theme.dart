import 'package:calorie_lens_ai_app/core/sizes/app_sizes.dart';
import 'package:calorie_lens_ai_app/core/ui/shape/app_shapes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // AppBar için SystemUiOverlayStyle

class AppTheme {
  // Renk Paletleri (Ana Renkleri Tanımlıyoruz)
  static const Color lightPrimaryColor =
      Color(0xFF66BB6A); // Açık tema ana rengi (yeşil tonu)
  static const Color lightPrimaryVariant = Color(0xFF388E3C);
  static const Color lightAccentColor =
      Color(0xFFFF9800); // Vurgu rengi (Turuncu)
  static const Color lightBackgroundColor = Color(0xFFF0F2F5); // Arka plan
  static const Color lightSurfaceColor = Colors.white; // Kartlar, dialoglar vb.
  static const Color lightTextColor = Color(0xFF212121); // Ana metin
  static const Color lightSecondaryTextColor =
      Color(0xFF757575); // İkincil metin
  static const Color lightErrorColor = Color(0xFFD32F2F); // Hata rengi
  static const Color lightButtonColor = lightPrimaryColor;
  static const Color lightIconColor = lightTextColor;

  static const Color darkPrimaryColor =
      Color(0xFF4CAF50); // Koyu tema ana rengi (biraz daha açık yeşil)
  static const Color darkPrimaryVariant = Color(0xFF2E7D32);
  static const Color darkAccentColor = Color(0xFF81C784); // Vurgu rengi
  static const Color darkBackgroundColor = Color(0xFF121212); // Koyu arka plan
  static const Color darkSurfaceColor =
      Color(0xFF1E1E1E); // Koyu kartlar, dialoglar vb.
  static const Color darkTextColor = Color(0xFFE0E0E0); // Koyu tema ana metin
  static const Color darkSecondaryTextColor =
      Color(0xFFB0B0B0); // Koyu ikincil metin
  static const Color darkErrorColor = Color(0xFFEF9A9A); // Koyu hata rengi
  static const Color darkButtonColor = darkPrimaryColor;
  static const Color darkIconColor = darkTextColor;

  // Genişletilmiş renk paleti (isteğe bağlı, daha fazla detay için)
  static const Color infoColor = Color(0xFF2196F3); // Bilgi rengi (mavi)
  static const Color warningColor = Color(0xFFFFC107); // Uyarı rengi (sarı)
  static const Color successColor = Color(0xFF4CAF50); // Başarı rengi (yeşil)

  //----------------- AÇIK TEMA TANIMI -----------------
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: lightPrimaryColor,
      // ColorScheme modern temalarda daha iyi kontrol sağlar
      colorScheme: const ColorScheme.light(
        primary: lightPrimaryColor,
        primaryContainer: lightPrimaryVariant, // primaryVariant yerine
        secondary: lightAccentColor,
        secondaryContainer:
            lightAccentColor, // Vurgu varyantı yoksa secondary ile aynı olabilir
        surface: lightSurfaceColor,
        error: lightErrorColor,
        onPrimary: Colors.white, // Primary üzerinde görünen metin/ikon rengi
        onSecondary:
            Colors.white, // Secondary üzerinde görünen metin/ikon rengi
        onSurface: lightTextColor, // Surface üzerinde görünen metin/ikon rengi
        onError: Colors.white, // Error üzerinde görünen metin/ikon rengi
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: lightBackgroundColor,
      cardColor: lightSurfaceColor, // Kartların rengi
      dialogTheme: const DialogThemeData(
          backgroundColor: lightSurfaceColor), // Dialogların rengi
      dividerColor: Colors.grey[300], // Bölücü çizgilerin rengi
      hoverColor:
          lightPrimaryColor.withValues(alpha: 0.1), // Üzerine gelindiğinde
      splashColor: lightPrimaryColor.withValues(alpha: 0.2), // Basıldığında

      // Metin Temaları
      textTheme: const TextTheme(
        displayLarge: TextStyle(
            fontSize: AppSizes.s96,
            fontWeight: FontWeight.w300,
            color: lightTextColor),
        displayMedium: TextStyle(
            fontSize: AppSizes.s60,
            fontWeight: FontWeight.w400,
            color: lightTextColor),
        displaySmall: TextStyle(
            fontSize: AppSizes.s48,
            fontWeight: FontWeight.w400,
            color: lightTextColor),
        headlineLarge: TextStyle(
            fontSize: AppSizes.s40,
            fontWeight: FontWeight.w500,
            color: lightTextColor),
        headlineMedium: TextStyle(
            fontSize: AppSizes.s34,
            fontWeight: FontWeight.w400,
            color: lightTextColor),
        headlineSmall: TextStyle(
            fontSize: AppSizes.s24,
            fontWeight: FontWeight.w400,
            color: lightTextColor),
        titleLarge: TextStyle(
            fontSize: AppSizes.s20,
            fontWeight: FontWeight.w500,
            color: lightTextColor), // App bar title vb.
        titleMedium: TextStyle(
            fontSize: AppSizes.s16,
            fontWeight: FontWeight.w500,
            color: lightTextColor),
        titleSmall: TextStyle(
            fontSize: AppSizes.s14,
            fontWeight: FontWeight.w500,
            color: lightTextColor),
        bodyLarge: TextStyle(
            fontSize: AppSizes.s16,
            fontWeight: FontWeight.w400,
            color: lightTextColor), // Varsayılan metin
        bodyMedium: TextStyle(
            fontSize: AppSizes.s14,
            fontWeight: FontWeight.w400,
            color: lightTextColor), // Varsayılan metin
        bodySmall: TextStyle(
            fontSize: AppSizes.s12,
            fontWeight: FontWeight.w400,
            color: lightSecondaryTextColor),
        labelLarge: TextStyle(
            fontSize: AppSizes.s14,
            fontWeight: FontWeight.w500,
            color: Colors.white), // Buton metinleri
        labelMedium: TextStyle(
            fontSize: AppSizes.s12,
            fontWeight: FontWeight.w400,
            color: lightSecondaryTextColor),
        labelSmall: TextStyle(
            fontSize: AppSizes.s10,
            fontWeight: FontWeight.w400,
            color: lightSecondaryTextColor),
      ),

      // AppBar Teması
      appBarTheme: AppBarTheme(
        backgroundColor: lightPrimaryColor,
        elevation: AppSizes.s0, // Gölge olmasın
        foregroundColor: Colors.white, // AppBar üzerindeki ikon ve metin rengi
        systemOverlayStyle: SystemUiOverlayStyle
            .light, // Status bar ikonları açık temada açık renkli olsun
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: AppSizes.s20,
          fontWeight: FontWeight.w500,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actionsIconTheme: const IconThemeData(color: Colors.white),
      ),

      // Buton Temaları
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: lightButtonColor, // Buton arka plan rengi
          foregroundColor: Colors.white, // Buton metin/ikon rengi
          padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.s24, vertical: AppSizes.s12),
          shape: AppShapes.button,
          textStyle: const TextStyle(
              fontSize: AppSizes.s16, fontWeight: FontWeight.w500),
          elevation: AppSizes.s2,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: lightPrimaryColor,
          textStyle: const TextStyle(
              fontSize: AppSizes.s16, fontWeight: FontWeight.w500),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: lightPrimaryColor,
          side: const BorderSide(color: lightPrimaryColor, width: 1.5),
          padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.s24, vertical: AppSizes.s12),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.s8)),
          textStyle: const TextStyle(
              fontSize: AppSizes.s16, fontWeight: FontWeight.w500),
        ),
      ),

      // Input Field Teması (TextInputField, TextFormField)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: lightSurfaceColor,
        hintStyle:
            TextStyle(color: lightSecondaryTextColor.withValues(alpha: 0.7)),
        labelStyle: const TextStyle(color: lightPrimaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.s8),
          borderSide: BorderSide.none, // Varsayılan olarak çerçevesiz
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.s8),
          borderSide:
              const BorderSide(color: lightPrimaryColor, width: AppSizes.s2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.s8),
          borderSide: BorderSide(color: Colors.grey[300]!, width: AppSizes.s1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.s8),
          borderSide:
              const BorderSide(color: lightErrorColor, width: AppSizes.s2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.s8),
          borderSide:
              const BorderSide(color: lightErrorColor, width: AppSizes.s2),
        ),
        contentPadding: const EdgeInsets.symmetric(
            vertical: AppSizes.s14, horizontal: AppSizes.s16),
      ),

      // Icon Teması
      iconTheme: const IconThemeData(color: lightIconColor, size: AppSizes.s24),

      // Card Teması
      cardTheme: CardThemeData(
        color: lightSurfaceColor,
        elevation: AppSizes.s2,
        shape: AppShapes.card,
        margin: const EdgeInsets.all(AppSizes.s8),
      ),

      // BottomNavigationBar Teması
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: lightSurfaceColor,
        selectedItemColor: lightPrimaryColor,
        unselectedItemColor: lightSecondaryTextColor,
        selectedLabelStyle: const TextStyle(
            fontSize: AppSizes.s12, fontWeight: FontWeight.w500),
        unselectedLabelStyle: const TextStyle(fontSize: AppSizes.s12),
        elevation: AppSizes.s8,
        type: BottomNavigationBarType.fixed, // Eğer 4+ öğe varsa
      ),

      // TabBar Teması
      tabBarTheme: TabBarThemeData(
        labelColor: lightPrimaryColor,
        unselectedLabelColor: lightSecondaryTextColor,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: lightPrimaryColor, width: 3.0),
        ),
        labelStyle: const TextStyle(fontWeight: FontWeight.w600),
      ),

      // FloatingActionButton Teması
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: lightAccentColor,
        foregroundColor: Colors.white,
        elevation: AppSizes.s4,
      ),

      // Progress Indicator Teması
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: lightPrimaryColor,
        circularTrackColor: Colors.grey,
        linearTrackColor: Colors.grey,
      ),

      // Slider Teması
      sliderTheme: SliderThemeData(
        activeTrackColor: lightPrimaryColor,
        inactiveTrackColor: lightPrimaryColor.withValues(alpha: 0.3),
        thumbColor: lightPrimaryColor,
        overlayColor: lightPrimaryColor.withValues(alpha: 0.2),
        valueIndicatorColor: lightPrimaryColor,
      ),
    );
  }

  //----------------- KOYU TEMA TANIMI -----------------
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: darkPrimaryColor,
      colorScheme: const ColorScheme.dark(
        primary: darkPrimaryColor,
        primaryContainer: darkPrimaryVariant,
        secondary: darkAccentColor,
        secondaryContainer: darkAccentColor,
        surface: darkSurfaceColor,
        error: darkErrorColor,
        onPrimary: Colors.black, // Koyu tema primary üzerinde metin siyah
        onSecondary: Colors.black,
        onSurface: darkTextColor,
        onError: Colors.black,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: darkBackgroundColor,
      cardColor: darkSurfaceColor,
      dialogTheme: const DialogThemeData(backgroundColor: darkSurfaceColor),
      dividerColor: Colors.grey[700],
      hoverColor: darkPrimaryColor.withValues(alpha: 0.1),
      splashColor: darkPrimaryColor.withValues(alpha: 0.2),

      // Metin Temaları
      textTheme: const TextTheme(
        displayLarge: TextStyle(
            fontSize: AppSizes.s96,
            fontWeight: FontWeight.w300,
            color: darkTextColor),
        displayMedium: TextStyle(
            fontSize: AppSizes.s60,
            fontWeight: FontWeight.w400,
            color: darkTextColor),
        displaySmall: TextStyle(
            fontSize: AppSizes.s48,
            fontWeight: FontWeight.w400,
            color: darkTextColor),
        headlineLarge: TextStyle(
            fontSize: AppSizes.s40,
            fontWeight: FontWeight.w500,
            color: darkTextColor),
        headlineMedium: TextStyle(
            fontSize: AppSizes.s34,
            fontWeight: FontWeight.w400,
            color: darkTextColor),
        headlineSmall: TextStyle(
            fontSize: AppSizes.s24,
            fontWeight: FontWeight.w400,
            color: darkTextColor),
        titleLarge: TextStyle(
            fontSize: AppSizes.s20,
            fontWeight: FontWeight.w500,
            color: darkTextColor),
        titleMedium: TextStyle(
            fontSize: AppSizes.s16,
            fontWeight: FontWeight.w500,
            color: darkTextColor),
        titleSmall: TextStyle(
            fontSize: AppSizes.s14,
            fontWeight: FontWeight.w500,
            color: darkTextColor),
        bodyLarge: TextStyle(
            fontSize: AppSizes.s16,
            fontWeight: FontWeight.w400,
            color: darkTextColor),
        bodyMedium: TextStyle(
            fontSize: AppSizes.s14,
            fontWeight: FontWeight.w400,
            color: darkTextColor),
        bodySmall: TextStyle(
            fontSize: AppSizes.s12,
            fontWeight: FontWeight.w400,
            color: darkSecondaryTextColor),
        labelLarge: TextStyle(
            fontSize: AppSizes.s14,
            fontWeight: FontWeight.w500,
            color: Colors.black), // Koyu temada buton metni siyah
        labelMedium: TextStyle(
            fontSize: AppSizes.s12,
            fontWeight: FontWeight.w400,
            color: darkSecondaryTextColor),
        labelSmall: TextStyle(
            fontSize: AppSizes.s10,
            fontWeight: FontWeight.w400,
            color: darkSecondaryTextColor),
      ),

      // AppBar Teması
      appBarTheme: AppBarTheme(
        backgroundColor:
            darkSurfaceColor, // Koyu temada AppBar yüzey rengiyle aynı olabilir
        elevation: AppSizes.s0,
        foregroundColor: darkTextColor,
        systemOverlayStyle: SystemUiOverlayStyle
            .dark, // Status bar ikonları koyu temada koyu renkli olsun
        titleTextStyle: const TextStyle(
          color: darkTextColor,
          fontSize: AppSizes.s20,
          fontWeight: FontWeight.w500,
        ),
        iconTheme: const IconThemeData(color: darkTextColor),
        actionsIconTheme: const IconThemeData(color: darkTextColor),
      ),

      // Buton Temaları
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: darkButtonColor,
          foregroundColor:
              Colors.black, // Koyu temada buton metni/ikon rengi siyah
          padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.s24, vertical: AppSizes.s12),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.s8)),
          textStyle: const TextStyle(
              fontSize: AppSizes.s16, fontWeight: FontWeight.w500),
          elevation: AppSizes.s2,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: darkPrimaryColor,
          textStyle: const TextStyle(
              fontSize: AppSizes.s16, fontWeight: FontWeight.w500),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: darkPrimaryColor,
          side: const BorderSide(color: darkPrimaryColor, width: 1.5),
          padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.s24, vertical: AppSizes.s12),
          shape: AppShapes.button,
          textStyle: const TextStyle(
              fontSize: AppSizes.s16, fontWeight: FontWeight.w500),
        ),
      ),

      // Input Field Teması
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor:
            darkBackgroundColor, // Koyu temada input alanı arka planı biraz daha koyu olabilir
        hintStyle:
            TextStyle(color: darkSecondaryTextColor.withValues(alpha: 0.7)),
        labelStyle: const TextStyle(color: darkPrimaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: darkPrimaryColor, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[700]!, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: darkErrorColor, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: darkErrorColor, width: 2),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      ),

      // Icon Teması
      iconTheme: const IconThemeData(color: darkIconColor, size: 24),

      // Card Teması
      cardTheme: CardThemeData(
        color: darkSurfaceColor,
        elevation: 2,
        shape: AppShapes.card,
        margin: const EdgeInsets.all(8),
      ),

      // BottomNavigationBar Teması
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: darkSurfaceColor,
        selectedItemColor: darkPrimaryColor,
        unselectedItemColor: darkSecondaryTextColor,
        selectedLabelStyle: const TextStyle(
            fontSize: AppSizes.s12, fontWeight: FontWeight.w500),
        unselectedLabelStyle: const TextStyle(fontSize: AppSizes.s12),
        elevation: AppSizes.s8,
        type: BottomNavigationBarType.fixed,
      ),

      // TabBar Teması
      tabBarTheme: TabBarThemeData(
        labelColor: darkPrimaryColor,
        unselectedLabelColor: darkSecondaryTextColor,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: darkPrimaryColor, width: 3.0),
        ),
        labelStyle: const TextStyle(fontWeight: FontWeight.w600),
      ),

      // FloatingActionButton Teması
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: darkAccentColor,
        foregroundColor: Colors.black, // Koyu temada FAB metni siyah
        elevation: AppSizes.s4,
      ),

      // Progress Indicator Teması
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: darkPrimaryColor,
        circularTrackColor: Colors.grey,
        linearTrackColor: Colors.grey,
      ),

      // Slider Teması
      sliderTheme: SliderThemeData(
        activeTrackColor: darkPrimaryColor,
        inactiveTrackColor: darkPrimaryColor.withValues(alpha: 0.3),
        thumbColor: darkPrimaryColor,
        overlayColor: darkPrimaryColor.withValues(alpha: 0.2),
        valueIndicatorColor: darkPrimaryColor,
      ),
    );
  }
}
