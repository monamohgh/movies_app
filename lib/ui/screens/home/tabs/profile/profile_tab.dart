import 'package:flutter/material.dart';
import 'package:movies_app/ui/screens/updateprofile/update_profile.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';
import '../../../../../utils/data_store.dart';
import 'package:movies_app/l10n/app_localizations.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  String userName = 'John Safwat';
  String userPhone = '01200000000';
  String userAvatar = AppAssets.avatar1;

  double scaleW(BuildContext context, double w) => (w / 430) * context.width;
  double scaleH(BuildContext context, double h) => (h / 932) * context.height;

  Future<void> _navigateToUpdateProfile() async {
    final result = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateProfileScreen(
          currentName: userName,
          currentPhone: userPhone,
          currentAvatar: userAvatar,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        userName = result['name'] ?? userName;
        userPhone = result['phone'] ?? userPhone;
        userAvatar = result['avatar'] ?? userAvatar;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          localizations.profile,
          style: AppStyles.bold20White,
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            SizedBox(height: scaleH(context, 10)),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: scaleW(context, 16)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // User Info
                      Column(
                        children: [
                          Container(
                            width: scaleW(context, 80),
                            height: scaleW(context, 80),
                            decoration: const BoxDecoration(shape: BoxShape.circle),
                            child: ClipOval(
                              child: Image.asset(
                                userAvatar,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Image.asset(
                                  AppAssets.avatar1,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: scaleH(context, 8)),
                          Text(
                            userName,
                            style: AppStyles.bold20White,
                          ),
                        ],
                      ),

                      // Watch List Counter
                      Column(
                        children: [
                          Text(
                            '${MovieDataStore.watchList.length}',
                            style: AppStyles.bold24White,
                          ),
                          SizedBox(height: scaleH(context, 4)),
                          Text(
                            localizations.watch_list,
                            style: AppStyles.regular16White,
                          ),
                        ],
                      ),

                      // History Counter
                      Column(
                        children: [
                          Text(
                            '${MovieDataStore.historyList.length}',
                            style: AppStyles.bold24White,
                          ),
                          SizedBox(height: scaleH(context, 4)),
                          Text(
                            localizations.history,
                            style: AppStyles.regular16White,
                          ),
                        ],
                      ),
                      SizedBox(width: scaleW(context, 4)),
                    ],
                  ),

                  SizedBox(height: scaleH(context, 20)),

                  /// Action Buttons Row
                  Row(
                    children: [
                      // Edit Profile Button
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          height: scaleH(context, 48),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: _navigateToUpdateProfile,
                            child: Text(
                              localizations.edit_profile,
                              style: AppStyles.bold16Black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: scaleW(context, 12)),

                      // Exit Button
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: scaleH(context, 48),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.redColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  localizations.exit,
                                  style: AppStyles.regular15White,
                                ),
                                SizedBox(width: scaleW(context, 6)),
                                Icon(
                                  Icons.exit_to_app,
                                  color: AppColors.whiteColor,
                                  size: scaleW(context, 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: scaleH(context, 24)),

            /// Custom TabBar (Watch List & History)
            TabBar(
              indicatorColor: AppColors.primaryColor,
              indicatorWeight: 3,
              labelColor: AppColors.primaryColor,
              unselectedLabelColor: AppColors.whiteColor,
              labelStyle: AppStyles.regular15White,
              tabs: const [
                Tab(
                  icon: Icon(Icons.format_list_bulleted),
                  text: 'Watch List',
                ),
                Tab(
                  icon: Icon(Icons.folder),
                  text: 'History',
                ),
              ],
            ),

            /// TabBar Views Content Connected to Store Lists
            Expanded(
              child: TabBarView(
                children: [
                  _buildMovieList(MovieDataStore.watchList),
                  _buildMovieList(MovieDataStore.historyList),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMovieList(List<SavedMovie> movies) {
    if (movies.isEmpty) {
      return _buildEmptyState(context);
    }

    return GridView.builder(
      padding: EdgeInsets.all(scaleW(context, 16)),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: scaleW(context, 12),
        mainAxisSpacing: scaleH(context, 12),
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.lightGreyColor.withValues(alpha: 0.2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    movie.imageUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.movie, color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  movie.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.regular15White,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppAssets.empty,
            width: scaleW(context, 120),
            height: scaleH(context, 120),
          ),
          SizedBox(height: scaleH(context, 16)),
          Text(
            'No Data Found',
            style: AppStyles.regular16White.copyWith(
              color: AppColors.lightGreyColor,
            ),
          ),
        ],
      ),
    );
  }
}