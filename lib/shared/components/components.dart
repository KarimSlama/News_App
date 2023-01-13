import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/web_view_screen/web_view_screen.dart';

Widget newsListBuilder(articles, context) => InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebViewScreen(
              articles['url'],
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          height: 280.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(20.0),
            color: Colors.grey[200],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200.0,
                decoration: BoxDecoration(
                  color: Colors.cyan,
                  borderRadius: BorderRadiusDirectional.circular(20.0),
                  image: DecorationImage(
                    image: NetworkImage('${articles['urlToImage']}'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsetsDirectional.only(end: 10.0, start: 10.0),
                  child: Text(
                    '${articles['title']}',
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsetsDirectional.only(end: 10.0, start: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${articles['publishedAt']}',
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.black54,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(
                        width: 50.0,
                      ),
                      Expanded(
                        child: Text(
                          '${articles['source']['name']}',
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.black54,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

Widget spaceLine() => Container(
      height: 1,
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 25.0),
      color: Colors.black12,
    );

Widget newsArticlesBuilder({article, isSearched = false}) => ConditionalBuilder(
      ///if some errors happen with this line state is! NewsGetBusinessDataLoading instead use
      ///businessList.length > 0;
      condition: article.length > 0,
      builder: (context) {
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) =>
              newsListBuilder(article[index], context),
          separatorBuilder: (context, index) => spaceLine(),
          itemCount: article.length,
        );
      },
      fallback: (context) => Center(
        child: isSearched ? Container() : const CircularProgressIndicator(),
      ),
    );
