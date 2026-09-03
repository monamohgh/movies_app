import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/api/dio_manager.dart';
import 'package:movies_app/blocs/browse_cubit.dart';
import 'package:movies_app/ui/screens/home/tabs/browse/widgets/categories_list.dart';
import 'package:movies_app/ui/screens/home/tabs/browse/widgets/movies_grid_view.dart';
import 'package:movies_app/utils/size_utils.dart';
import '../../../../../utils/app_colors.dart';



class BrowseTab extends StatelessWidget {
  const BrowseTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => BrowseCubit(DioManager())..getBrowseData(),
      child: Scaffold(
        backgroundColor: AppColors.blackColor,
        body: BlocBuilder<BrowseCubit,BrowseState>(
          builder: (context, state) {
           if(state is BrowseLoadingState){
             return Center(child: CircularProgressIndicator(color:AppColors.primaryColor ),);
           }
           if(state is BrowseErrorState){
             return Center(child: Text(state.errorMessage));
           }
           if(state is BrowseSuccessState){
             return SafeArea(
               child: Column(
                 children: [
                   CategoriesList(categories: state.categories.toList(), selectedCategory: state.selectedGenre,
                       onCategorySelected:(newGenre) {
                       context.read<BrowseCubit>().changeSelectedGenre(newGenre);
                       },),
                   Expanded(
                     child: Padding(
                       padding:  EdgeInsets.symmetric(horizontal: context.width*.02,vertical: context.height*.02 ),
                       child: Center(
                      child:  MoviesGridView(movies: state.filteredMovies,)
                       ),
                     ),
                   ),
                 ],
               ),
             );
           }
           return Container();
          },
        ),
      ),
    );
  }
}
