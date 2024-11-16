import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../helper/category_data.dart';
import '../helper/newsdata.dart';
import '../login.dart';
import '../model/category_model.dart';
import '../model/news_model.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
 int currentIndex=0;
  // Category and news lists
  List<Category_Model> categories = [];
  List<News_Model> articles = [];
  Set<int> bookmarkedArticles = {}; // To store bookmarked article indices
  bool isLoading = true;
  late PageController _pageController;
  bool hasShownScrollHint = false;
  bool showSwipeHint = true;

  // Fetch news data
  getNews() async {
    NewsData newsData = NewsData();
    await newsData.getNews();
    setState(() {
      articles = newsData.dataToBeSavedIn;
      isLoading = false;
    });

    // Show scroll hint animation
    if (!hasShownScrollHint) {
      Future.delayed(const Duration(seconds: 2), () {
        _pageController.animateToPage(
          1,
          duration: const Duration(seconds: 2),
          curve: Curves.easeInOut,
        );
        Future.delayed(const Duration(seconds: 2), () {
          _pageController.animateToPage(
            0,
            duration: const Duration(seconds: 2),
            curve: Curves.easeInOut,
          );
        });

        // Hide the swipe hint after the animation
        Future.delayed(const Duration(seconds: 4), () {
          setState(() {
            showSwipeHint = false;
          });
        });
      });

      hasShownScrollHint = true;
    }
  }

  void toggleBookmark(int index) {
    setState(() {
      if (bookmarkedArticles.contains(index)) {
        bookmarkedArticles.remove(index);
      } else {
        bookmarkedArticles.add(index);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    categories = getCategories();
    _pageController = PageController();
    getNews();
  }

  void fetchCategoryNews(String category) {
    setState(() {
      // Filter news based on the category
      if (category == 'All') {

      } else {

      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 62,
        title: const SizedBox(
          width: 360,
          child: Text(
            'News',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
              color: Colors.white,
            ),
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(18, 44, 103, 1),
                Color.fromRGBO(36, 88, 205, 1),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [

          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_list,color: Colors.white,),
            onSelected: (String value) {
              // Handle dropdown selection
              if (value == 'All') {
                // Fetch all news
                getNews();
              } else {
                // Fetch category-specific news
                fetchCategoryNews(value);
              }
            },
            itemBuilder: (BuildContext context) {
              return const [
                PopupMenuItem(value: 'All', child: Text('All')),
                PopupMenuItem(value: 'National', child: Text('National')),
                PopupMenuItem(value: 'Business', child: Text('Business')),
                PopupMenuItem(value: 'Sports', child: Text('Sports')),
                PopupMenuItem(value: 'World', child: Text('World')),
                PopupMenuItem(value: 'Politics', child: Text('Politics')),
                PopupMenuItem(value: 'Technology', child: Text('Technology')),
                PopupMenuItem(value: 'Startup', child: Text('Startup')),
                PopupMenuItem(value: 'Entertainment', child: Text('Entertainment')),
                PopupMenuItem(value: 'Miscellaneous', child: Text('Miscellaneous')),
                PopupMenuItem(value: 'Hatke', child: Text('Hatke')),
                PopupMenuItem(value: 'Science', child: Text('Science')),
                PopupMenuItem(value: 'Automobile', child: Text('Automobile')),
              ];
            },
          ),
        ],
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
        children: [
          // News content
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                // Category widgets
                Container(
                  height: 90,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: ListView.builder(
                    itemCount: categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return CategoryDesign(
                        imageUrl: categories[index].imageUrl,
                        categoryName: categories[index].categoryName,
                      );
                    },
                  ),
                ),

                // News widgets
                SizedBox(
                  height: MediaQuery.of(context).size.height - 160,
                  child: PageView.builder(
                    controller: _pageController,
                    scrollDirection: Axis.vertical,
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      return NewsTemplate(
                        urlToImage: articles[index].urlToImage,
                        title: articles[index].title,
                        description: articles[index].description,
                        url: articles[index].url,
                        isBookmarked: bookmarkedArticles.contains(index),
                        onBookmarkToggle: () => toggleBookmark(index),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });


          if (index == 0) {

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Homepage(),
              ),
            );
          } else if (index == 1) {

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookmarkedArticlesScreen(
                  articles: articles,
                  bookmarkedIndices: bookmarkedArticles.toList(),
                ),
              ),
            );
          } else if (index == 2) {

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Login(),
              ),
            );
          }
        },
        backgroundColor: const Color.fromRGBO(18, 44, 103, 1), // Background color for BottomNavigationBar
        selectedItemColor: Colors.white, // Selected item color
        unselectedItemColor: Colors.grey, // Unselected item color
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmarks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Log Out',
          ),
        ],
      ),

    );
  }
}



class CategoryDesign extends StatelessWidget {
  final String categoryName, imageUrl;
  const CategoryDesign({required this.categoryName, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 6, top: 6),
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.black26,
            ),
            child: Text(
              categoryName,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class NewsTemplate extends StatelessWidget {
  final String title, description, url, urlToImage;
  final bool isBookmarked;
  final VoidCallback onBookmarkToggle;

  const NewsTemplate({
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.isBookmarked,
    required this.onBookmarkToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: CachedNetworkImage(
              imageUrl: urlToImage,
              width: double.infinity,
              height: 350,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  color: isBookmarked ? Colors.blue : Colors.grey,
                ),
                onPressed: onBookmarkToggle,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}



class BookmarkedArticlesScreen extends StatefulWidget {
  final List<News_Model> articles;
  final List<int> bookmarkedIndices;

  const BookmarkedArticlesScreen({
    required this.articles,
    required this.bookmarkedIndices,
  });

  @override
  _BookmarkedArticlesScreenState createState() => _BookmarkedArticlesScreenState();
}

class _BookmarkedArticlesScreenState extends State<BookmarkedArticlesScreen> {
  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    final bookmarkedArticles =
    widget.bookmarkedIndices.map((index) => widget.articles[index]).toList();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.08), // Dynamic AppBar height
        child: AppBar(
          title: const Text(
            'Bookmarked Articles',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
              color: Colors.white,
            ),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(18, 44, 103, 1),
                  Color.fromRGBO(36, 88, 205, 1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
      ),
      body: bookmarkedArticles.isEmpty
          ? const Center(
        child: Text('No articles bookmarked yet.'),
      )
          : Padding(
        padding: const EdgeInsets.all(8.0), // Padding around ListView
        child: ListView.separated(
          itemCount: bookmarkedArticles.length,
          itemBuilder: (context, index) {
            final article = bookmarkedArticles[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // Rounded corners
              ),
              elevation: 4, // Shadow effect for cards
              child: ListTile(
                contentPadding: const EdgeInsets.all(12),
                title: Text(
                  article.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  article.description,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
                leading: article.urlToImage.isNotEmpty
                    ? CachedNetworkImage(
                  imageUrl: article.urlToImage,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                )
                    : const Icon(
                  Icons.bookmark_add,
                  color: Colors.blue,
                  size: 24,
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const Divider(
            thickness: 0.5,
            color: Colors.grey,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });

          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Homepage(),
              ),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookmarkedArticlesScreen(
                  articles: widget.articles,
                  bookmarkedIndices: widget.bookmarkedIndices,
                ),
              ),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Login(),
              ),
            );
          }
        },
        backgroundColor: const Color.fromRGBO(18, 44, 103, 1), // Background color for BottomNavigationBar
        selectedItemColor: Colors.white, // Selected item color
        unselectedItemColor: Colors.grey, // Unselected item color
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmarks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Log Out',
          ),
        ],
      ),
    );
  }
}
