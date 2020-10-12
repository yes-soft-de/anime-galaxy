
import 'package:anime_galaxy/module_anime/model/anime_model/anime_model.dart';
import 'package:anime_galaxy/module_network/http_client/http_client.dart';
import 'package:inject/inject.dart';

// mock up data
List<Comment> comments=[
  new Comment(date: '21 Jun',content: 'أتوقع أن يقوم فلان بالعمل الفلاني في الحلقة القادمة الحلقات تزداد روعة كل يوم',userName: 'ذوالفقار',userImage:'https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=100&q=60 100w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=200&q=60 200w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=300&q=60 300w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=60 400w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60 500w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=600&q=60 600w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=60 700w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60 800w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=900&q=60 900w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=60 1000w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=60 1100w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1200&q=60 1200w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60 1296w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=60 1400w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1600&q=60 1600w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1800&q=60 1800w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2000&q=60 2000w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2200&q=60 2200w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2400&q=60 2400w, https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2592&q=60 2592w' ),
  new Comment(date: '24 May',content:'هذه المسلسل جميل جدا',userName: 'فادي',userImage: 'https://images.unsplash.com/photo-1512353087810-25dfcd100962?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=100&q=60 100w, https://images.unsplash.com/photo-1512353087810-25dfcd100962?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=200&q=60 200w, https://images.unsplash.com/photo-1512353087810-25dfcd100962?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=300&q=60 300w, https://images.unsplash.com/photo-1512353087810-25dfcd100962?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=60 400w, https://images.unsplash.com/photo-1512353087810-25dfcd100962?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60 500w, https://images.unsplash.com/photo-1512353087810-25dfcd100962?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=600&q=60 600w, https://images.unsplash.com/photo-1512353087810-25dfcd100962?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=60 700w, https://images.unsplash.com/photo-1512353087810-25dfcd100962?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60 800w, https://images.unsplash.com/photo-1512353087810-25dfcd100962?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=900&q=60 900w, https://images.unsplash.com/photo-1512353087810-25dfcd100962?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=60 1000w, https://images.unsplash.com/photo-1512353087810-25dfcd100962?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=60 1100w, https://images.unsplash.com/photo-1512353087810-25dfcd100962?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1200&q=60 1200w, https://images.unsplash.com/photo-1512353087810-25dfcd100962?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1296&q=60 1296w, https://images.unsplash.com/photo-1512353087810-25dfcd100962?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=60 1400w, https://images.unsplash.com/photo-1512353087810-25dfcd100962?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1600&q=60 1600w, https://images.unsplash.com/photo-1512353087810-25dfcd100962?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1800&q=60 1800w, https://images.unsplash.com/photo-1512353087810-25dfcd100962?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2000&q=60 2000w, https://images.unsplash.com/photo-1512353087810-25dfcd100962?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2200&q=60 2200w, https://images.unsplash.com/photo-1512353087810-25dfcd100962?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2400&q=60 2400w, https://images.unsplash.com/photo-1512353087810-25dfcd100962?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2592&q=60 2592w'),
];

List<Episode> episodes = [
  new Episode(
    image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',
    episodeNumber: 1,
    classification: new AnimeClassification(name:'أكشن شاونين'),
  ),
  new Episode(
    image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',
    episodeNumber: 2,
    classification: new AnimeClassification(name:'أكشن شاونين'),
  ),
  new Episode(
    image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',
    episodeNumber: 3,
    classification: new AnimeClassification(name:'أكشن شاونين'),
  ),
  new Episode(
    image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',
    episodeNumber: 4,
    classification: new AnimeClassification(name:'أكشن شاونين'),
  ),
  new Episode(
    image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',
    episodeNumber: 5,
    classification: new AnimeClassification(name:'أكشن شاونين'),
  ),
  new Episode(
    image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',
    episodeNumber: 6,
    classification: new AnimeClassification(name:'أكشن شاونين'),
  ),

];

@provide
class AnimeDetailsRepository{
  final ApiClient _httpClient;

  AnimeDetailsRepository(this._httpClient);

  Future<AnimeModel> getAnimeDetails(int animeId)async{
    await Future.delayed(Duration(milliseconds: 4000));
    AnimeModel anime = new AnimeModel();
    anime.name = 'دكتور ستون-Dr .Stone';
    anime.showYear = '2020';
    anime.commentsNumber = 78;
    anime.likesNumber = 90;
    anime.rate = 4.6;
    anime.image = 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg';
    anime.about = 'تدور أحداث القصة عن سينكو هو عضو في نادي علوم ويحب العلم، يخبره صديقه تايجو، أنه على وشك أن يعترف بحبه لصديقته يوزوريها. يجتمع تايجو معها تحت شجرة الكافور في المدرسة، عندما أوشك تايجو على الاعتراف، ظهر ضوء ساطع في السماء، قام بتحويل كل إنسان على الأرض إلى حجر. لكن تايجو لا يزال على قيد الحياة مع تقدم السنين بفضل حافزه لتحرير نفسه ويوزوريها. يتحرر تايجو من الحجر ويجد رسالة محفورة على الشجرة تؤدي به إلى اكتشاف أن سينكو قد تحرر أيضًا من الحجر.';
    anime.episodes = await getEpisodes(animeId);
    anime.comments = await getComments(animeId);
    List<AnimeClassification> classifications =[
       new AnimeClassification(name: 'علوم'),
       new AnimeClassification(name: 'فانتازي'),
       new AnimeClassification(name: 'اكشن'),
    ];
    anime.classifications = classifications;

    return anime;

  }
  Future<List<Comment>> getComments(int animeId) async{
    await Future.delayed(Duration(milliseconds: 500));
    return comments;
  }
  Future<List<Episode>> getEpisodes(int animeId) async{
    await Future.delayed(Duration(milliseconds: 500));
    return episodes;
  }
}