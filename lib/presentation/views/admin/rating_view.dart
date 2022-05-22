import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kopiek_resto/common/utils/string_helper.dart';
import 'package:kopiek_resto/data/models/rating_model.dart';
import 'package:kopiek_resto/di/get_it.dart';
import 'package:kopiek_resto/presentation/blocs/admin/rating/rating_bloc.dart';
import 'package:kopiek_resto/presentation/theme/theme.dart';
import 'package:kopiek_resto/presentation/theme/theme_color.dart';
import 'package:kopiek_resto/presentation/views/loading/loading_circle.dart';
import 'package:kopiek_resto/presentation/widgets/errror_page.dart';

class RatingView extends StatefulWidget {
  const RatingView({Key? key}) : super(key: key);

  @override
  State<RatingView> createState() => _RatingViewState();
}

class _RatingViewState extends State<RatingView> {
  late RatingBloc _ratingBloc;

  @override
  initState(){
    super.initState();
    _ratingBloc = di<RatingBloc>();
    _ratingBloc.add(FetchRatingEvent());
  }

  @override
  void dispose() {
    super.dispose();
    _ratingBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>_ratingBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Rating'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: BlocBuilder<RatingBloc,RatingState>(
              builder: (context,state){
                if(state is RatingLoading){
                  return const Center(child: LoadingCircle(),);
                }else if (state is RatingFailure){
                  return ErrorPage(label: state.message, onPressed: (){
                    _ratingBloc.add(FetchRatingEvent());
                  });
                }else if(state is RatingLoaded){
                  return state.data.isEmpty?const Center(child: Text
                    ('Rating belum ada'),):
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ListView
                          .builder(
                        shrinkWrap: true,
                        itemCount: state.data.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context,index){
                          DataRating data = state.data[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                leading: const CircleAvatar(
                                  backgroundColor: AppColor.primary,
                                  child: Icon(Icons.person,color: Colors.white,),
                                  radius: 16,
                                ),
                                title: Text(data.user.nama),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RatingBarIndicator(
                                      rating: data.rating.toDouble(),
                                      itemBuilder: (context, index) => const
                          Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      itemCount: 5,
                                      itemSize: 12,
                                      direction: Axis.horizontal,
                                    ),
                                    data.catatan==null?const SizedBox.shrink()
                                        :Text(data.catatan!,style: greyTextStyle
                                        .copyWith(fontSize: 12),),
                                    Text(getDateDashboard(data.createdAt.toLocal()),style: greyTextStyle
                                        .copyWith(fontSize: 12),),
                                  ],
                                ),
                              ),
                              const Divider(),
                            ],
                          );
                        },
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            )
          ),
        ),
      ),
    );
  }
}
