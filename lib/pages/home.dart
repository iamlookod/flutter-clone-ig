import 'package:flutter/material.dart';
import 'package:myapp/models/post.dart';
import 'package:myapp/models/global.dart';
import 'package:myapp/models/user.dart';
import 'package:myapp/models/comment.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static int page = 1;
  static Post thePost = post1;
  List<Widget> pages = [];
  @override
  Widget build(BuildContext context) {
    Map<int, Widget> pageview = {
      1: getMain(),
      2: getLikes(thePost.likes),
      3: getComments(thePost.comments)
    };
    return pageview[page];
  }

  Widget getMain() {
    return Scaffold(
        appBar: AppBar(
            title: Image.asset(
          'lib/assets/logo.png',
          height: 40,
        )),
        body: Container(
            child: ListView(children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                child: getStories(),
                height: 70,
                margin: EdgeInsets.only(top: 10),
              ),
              Column(
                children: getPosts(context),
              ),
            ],
          ),
        ])));
  }

  List<Widget> getPosts(BuildContext context) {
    List<Widget> posts = [];
    int index = 0;
    for (Post post in userPosts) {
      posts.add(getPost(context, post, index));
      index++;
    }

    return posts;
  }

  Widget getStories() {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: getUserStories(),
    );
  }

  List<Widget> getUserStories() {
    List<Widget> stories = [];

    for (User follower in user.following) {
      stories.add(getStory(follower));
    }

    return stories;
  }

  Widget getStory(User follower) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Column(children: <Widget>[
        Container(
          height: 40,
          width: 40,
          child: Stack(
            alignment: Alignment(0, 0),
            children: <Widget>[
              Container(
                height: 40,
                width: 40,
                child: CircleAvatar(
                  backgroundColor:
                      follower.hasStory ? Colors.orange : Colors.grey,
                ),
              ),
              Container(
                height: 38,
                width: 38,
                child: CircleAvatar(backgroundColor: Colors.black),
              ),
              Container(
                height: 35,
                width: 35,
                child: CircleAvatar(backgroundImage: follower.profilePicture),
              ),
              FloatingActionButton(
                elevation: 0,
                backgroundColor: Colors.transparent,
                onPressed: () {},
              ),
            ],
          ),
        ),
        Text(follower.username)
      ]),
    );
  }

  Widget getPost(BuildContext context, Post post, int index) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child:
                        CircleAvatar(backgroundImage: post.user.profilePicture),
                  ),
                  Text(post.user.username)
                ]),
                IconButton(icon: Icon(Icons.more_horiz), onPressed: () {})
              ],
            ),
          ),
          Container(
            constraints: BoxConstraints.expand(height: 1),
          ),
          Container(
            constraints: BoxConstraints(maxHeight: 282),
            decoration:
                BoxDecoration(image: DecorationImage(image: post.image)),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(children: <Widget>[
                  Stack(
                    alignment: Alignment(0, 0),
                    children: <Widget>[
                      Icon(Icons.favorite,
                          size: 24,
                          color: post.isLiked ? Colors.orange : Colors.white),
                      IconButton(
                          icon: Icon(Icons.favorite,
                              color:
                                  post.isLiked ? Colors.orange : Colors.white),
                          onPressed: () {
                            setState(() {
                              userPosts[index].isLiked =
                                  post.isLiked ? false : true;
                              if (!post.isLiked) {
                                post.likes.remove(user);
                              } else {
                                post.likes.add(user);
                              }

                              print(post.likes.length);
                            });
                          })
                    ],
                  ),
                  Stack(
                    alignment: Alignment(0, 0),
                    children: <Widget>[
                      Icon(Icons.comment, size: 24, color: Colors.white),
                      IconButton(
                          icon: Icon(Icons.comment, color: Colors.white),
                          onPressed: () {})
                    ],
                  ),
                  Stack(
                    alignment: Alignment(0, 0),
                    children: <Widget>[
                      Icon(Icons.share, size: 24, color: Colors.white),
                      IconButton(
                          icon: Icon(Icons.share, color: Colors.white),
                          onPressed: () {})
                    ],
                  )
                ]),
                Stack(
                  alignment: Alignment(0, 0),
                  children: <Widget>[
                    Icon(Icons.bookmark,
                        size: 24,
                        color: post.isSaved ? Colors.orange : Colors.white),
                    IconButton(
                        icon: Icon(Icons.bookmark,
                            color: post.isSaved ? Colors.orange : Colors.white),
                        onPressed: () {
                          setState(() {
                            userPosts[index].isSaved =
                                post.isSaved ? false : true;
                            if (!post.isSaved) {
                              user.savedPosts.remove(post);
                            } else {
                              user.savedPosts.add(post);
                            }
                          });
                        })
                  ],
                )
              ]),
          FlatButton(
              onPressed: () {
                setState(() {
                  thePost = post;
                  page = 2;
                  build(context);
                });
              },
              child: Text(post.likes.length.toString() + ' like')),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 15, right: 10),
                child: Text(post.user.username),
              ),
              Text(post.description)
            ],
          ),
          FlatButton(
              onPressed: () {
                setState(() {
                  thePost = post;
                  page = 3;
                  build(context);
                });
              },
              child: Text(
                  'View all ' + post.comments.length.toString() + ' comments'))
        ],
      ),
    );
  }

  Widget getLikes(List<User> likes) {
    List<Widget> likers = [];
    for (User follower in likes) {
      likers.add(new Container(
          height: 45,
          padding: EdgeInsets.all(10),
          child: FlatButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(follower.username,
                    style: new TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white)),
                Container(
                  decoration: BoxDecoration(
                      // border: Border.all(width: 1, color: Colors.orange),
                      borderRadius: BorderRadius.all(Radius.circular(6))),
                  child: FlatButton(
                    color: user.following.contains(follower)
                        ? Colors.black
                        : Colors.orange,
                    child: Text(
                        user.following.contains(follower)
                            ? "Following"
                            : "Follow",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: user.following.contains(follower)
                                ? Colors.grey
                                : Colors.white)),
                    onPressed: () {
                      setState(() {
                        if (user.following.contains(follower)) {
                          user.following.remove(follower);
                        } else {
                          user.following.add(follower);
                        }
                      });
                    },
                  ),
                )
              ],
            ),
            onPressed: () {},
          )));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Likes",
            style: new TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white)),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            setState(() {
              page = 1;
              build(context);
            });
          },
        ),
      ),
      body: Container(
        child: ListView(
          children: likers,
        ),
      ),
    );
  }

  Widget getComments(List<Comment> likes) {
    List<Widget> likers = [];
    DateTime now = DateTime.now();
    for (Comment comment in likes) {
      int hoursAgo = (now.hour) - (comment.dateOfComment.hour - 1);
      likers.add(new Container(
          // height: 45,
          padding: EdgeInsets.all(10),
          child: FlatButton(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      width: 30,
                      height: 30,
                      child: CircleAvatar(
                        backgroundImage: comment.user.profilePicture,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        RichText(
                          text: new TextSpan(
                            style: new TextStyle(
                              fontSize: 14.0,
                              color: Colors.white,
                            ),
                            children: <TextSpan>[
                              new TextSpan(text: comment.user.username),
                              new TextSpan(text: ' '),
                              new TextSpan(text: comment.comment),
                            ],
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 10, top: 20),
                              child: Text(hoursAgo.toString() + "h"),
                            ),
                            Container(
                              child: Text("like"),
                              margin: EdgeInsets.only(right: 10, top: 20),
                            ),
                            Container(
                              child: Text("Reply"),
                              margin: EdgeInsets.only(right: 10, top: 20),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
                Stack(
                  alignment: Alignment(0, 0),
                  children: <Widget>[
                    Container(
                        child: Icon(
                      Icons.favorite,
                      color: Colors.orange,
                      size: 15,
                    )),
                    Container(
                      child: IconButton(
                        icon: Icon(Icons.favorite,
                            color:
                                comment.isLiked ? Colors.orange : Colors.white,
                            size: 10),
                        onPressed: () {
                          setState(() {
                            comment.isLiked = comment.isLiked ? false : true;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
            onPressed: () {},
          )));
    }

    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        page = 1;
                        build(context);
                      });
                    },
                  ),
                  Text('Comments')
                ],
              ),
              IconButton(
                icon: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
      body: Container(
        child: ListView(
          children: likers,
        ),
      ),
    );
  }
}
