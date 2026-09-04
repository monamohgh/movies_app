import 'package:flutter/material.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/ui/screens/home/tabs/browse/widgets/movie_card.dart';
import 'package:movies_app/utils/app_styles.dart';
import '../../../../../../model/movie_model.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/data_store.dart';
import '../../../../movie_details/movie_details_screen.dart';

class  MoviesGridView extends StatelessWidget {
  final List<MovieModel> movies;
  final bool isLoading;
  const  MoviesGridView({super.key,required this.movies,this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(
          color: AppColors.primaryColor,
        ),
      );
    }
   if(movies.isEmpty){
     return Center(
       child: Text(AppLocalizations.of(context)!.no_movies_found,style: AppStyles.bold16Primary,),
     );
   }
   return GridView.builder(
       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: .7,crossAxisSpacing: 12,mainAxisSpacing: 16),
     itemBuilder: (context, index) {
       final movie = movies[index];
       return MovieCard(
         imageUrl: movie.image,
         rating: movie.rating.toString(),
         onTap: () {

           final savedMovie = SavedMovie(
             id: movie.id,
             title: movie.title,
             imageUrl: movie.image,
             rating: movie.rating,
           );


           MovieDataStore.addToWatchList(savedMovie);


           Navigator.push(
             context,
             MaterialPageRoute(
               builder: (context) => MovieDetailsScreen(movieId: movie.id),
             ),
           );
         },
       );
     }
       ,itemCount: movies.length,
   );
  }
}
