class News {
  String id, createdTime, lastModifiedTime, content, banner, title;

  News({
    this.id,
    this.createdTime,
    this.lastModifiedTime,
    this.content,
    this.banner,
    this.title,
  });

  static final dummyDateTime = DateTime.now().toIso8601String();

  static final dummyNews = News(
    banner: 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2250&q=80',
    content: 'Tối nay 7h30, Ultimate band sẽ trở lại sân khấu của chúng ta'
      ' sau nhiều tuần vắng mặt, họ sẽ mang lại những bài hit nào? Cả nhà'
      ' đến ăn bánh, uống trà, nghe nhạc nhé!',
    title: 'Thứ bốn ngọt ngào của YAMA',
    createdTime: dummyDateTime,
  );

  static final List<News> mockNewsList = [
    dummyNews,
    dummyNews,
    dummyNews,
    dummyNews,
    dummyNews
  ];
}