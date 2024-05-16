import 'package:flutter/material.dart';

class BlogsScreen extends StatefulWidget {
  const BlogsScreen({Key? key}) : super(key: key);

  @override
  _BlogsScreenState createState() => _BlogsScreenState();
}

class _BlogsScreenState extends State<BlogsScreen> {
  List<Map<String, String>> _blogs = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    // Simulate a network request
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _blogs = [
        {
          'title': 'First Blog Post',
          'summary': 'This is the summary of the first blog post.',
          'image': 'https://via.placeholder.com/600',
          'user': 'User1',
          'avatar': 'https://via.placeholder.com/50'
        },
        {
          'title': 'Second Blog Post',
          'summary': 'This is the summary of the second blog post.',
          'image': 'https://via.placeholder.com/600',
          'user': 'User2',
          'avatar': 'https://via.placeholder.com/50'
        },
        // Add more blog posts here
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Blogs',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
          ),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: _fetchData,
        child: _blogs.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: _blogs.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    margin: const EdgeInsets.only(bottom: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(_blogs[index]['avatar']!),
                          ),
                          title: Text(
                            _blogs[index]['user']!,
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.more_vert),
                            onPressed: () {
                              // Add action for more options
                            },
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            _blogs[index]['image']!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 200.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _blogs[index]['title']!,
                                style: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22.0,
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              Text(
                                _blogs[index]['summary']!,
                                style: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 16.0,
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.thumb_up),
                                        onPressed: () {
                                          // Add like action
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.comment),
                                        onPressed: () {
                                          // Add comment action
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.share),
                                        onPressed: () {
                                          // Add share action
                                        },
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.bookmark_border),
                                    onPressed: () {
                                      // Add bookmark action
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
