import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/article.dart';
import 'package:newsapp/detail_page.dart';
import 'package:newsapp/article_webview.dart';
import 'package:newsapp/styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    final TextTheme myTextTheme = TextTheme(
      displayLarge: GoogleFonts.merriweather(
          fontSize: 92, fontWeight: FontWeight.w300, letterSpacing: -1.5),
      displayMedium: GoogleFonts.merriweather(
          fontSize: 57, fontWeight: FontWeight.w300, letterSpacing: -0.5),
      displaySmall:
      GoogleFonts.merriweather(fontSize: 46, fontWeight: FontWeight.w400),
      headlineMedium: GoogleFonts.merriweather(
          fontSize: 32, fontWeight: FontWeight.w400, letterSpacing: 0.25),
      headlineSmall:
      GoogleFonts.merriweather(fontSize: 23, fontWeight: FontWeight.w400),
      titleLarge: GoogleFonts.merriweather(
          fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15),
      titleMedium: GoogleFonts.merriweather(
          fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15),
      titleSmall: GoogleFonts.merriweather(
          fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 0.1),
      bodyLarge: GoogleFonts.libreFranklin(
          fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
      bodyMedium: GoogleFonts.libreFranklin(
          fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
      labelLarge: GoogleFonts.libreFranklin(
          fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
      bodySmall: GoogleFonts.libreFranklin(
          fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
      labelSmall: GoogleFonts.libreFranklin(
          fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
    );

    return MaterialApp(
      title: 'News APp',
      theme: ThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: primaryColor,
          onPrimary: Colors.black,
          secondary: secondaryColor,
        ),
        textTheme: myTextTheme,
        appBarTheme: AppBarTheme(elevation: 0),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: secondaryColor,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))
            )
          )
        )
      ),
      initialRoute: NewsListPage.routeName,
      routes: {
        NewsListPage.routeName: (context) => const NewsListPage(),
        ArticleDetailPage.routeName: (context) => ArticleDetailPage(
          article: ModalRoute.of(context)?.settings.arguments as Article,
        ),
        ArticleWebView.routeName: (context) => ArticleWebView(
          url: ModalRoute.of(context)?.settings.arguments as String,
        ),
      },
    );
  }
}


class NewsListPage extends StatelessWidget {
  static const routeName ='/article_list';

  const NewsListPage({Key? key}):super(key:key);

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: const Text('News App'),
     ),
     body: FutureBuilder<String>(
      future:
       DefaultAssetBundle.of(context).loadString('assets/articles.json'),
       builder: (context,snapshot) {
        final List<Article> articles = parseArticles(snapshot.data);
        return ListView.builder(itemCount:articles.length, itemBuilder: (context,index) {
            return _buildArticleItem(context,articles[index]);
        });
       },
     ),
   );
  }

  Widget _buildArticleItem(BuildContext context, Article article) {
    return ListTile(
      contentPadding:
      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: Image.network(
        article.urlToImage,
        width: 100,
        errorBuilder: (ctx, error, _) => const Center(child: Icon(Icons.error)),
      ),
      title: Text(article.title),
      subtitle: Text(article.author),
      onTap: () {
        Navigator.pushNamed(context, ArticleDetailPage.routeName,
            arguments: article);
      },
    );
  }

}