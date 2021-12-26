import 'package:flutter/material.dart';
import 'package:mixture_music_app/constants/enums/enums.dart';
import 'package:mixture_music_app/models/artist_model.dart';
import 'package:mixture_music_app/widgets/inkwell_wrapper.dart';
import 'package:mixture_music_app/widgets/loading_container.dart';

class ArtistCard extends StatelessWidget {
  const ArtistCard({
    Key? key,
    required this.artist,
    required this.onTap,
    required this.viewType,
  }) : super(key: key);

  final ArtistModel artist;
  final void Function() onTap;
  final ViewType viewType;

  @override
  Widget build(BuildContext context) {
    return InkWellWrapper(
      borderRadius: viewType == ViewType.grid ? const BorderRadius.all(Radius.circular(4.0)) : null,
      onTap: onTap,
      child: viewType == ViewType.list
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Row(
                children: [
                  ClipOval(
                    child: Image.network(
                      artist.imageUrl ?? '',
                      fit: BoxFit.cover,
                      width: 100.0,
                      height: 100.0,
                      loadingBuilder: (context, child, chunkEvent) {
                        if (chunkEvent == null) {
                          return child;
                        }
                        return LoadingContainer(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          width: 100.0,
                          height: 100.0,
                          borderRadius: BorderRadius.circular(20.0),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Text(
                      artist.artistName ?? '',
                      style: Theme.of(context).textTheme.caption?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 20.0,
                          ),
                    ),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ClipOval(
                    child: Image.network(
                      artist.imageUrl ?? '',
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.width * 0.4,
                      loadingBuilder: (context, child, chunkEvent) {
                        if (chunkEvent == null) {
                          return child;
                        }
                        return LoadingContainer(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.width * 0.4,
                          borderRadius: BorderRadius.circular(20.0),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    artist.artistName ?? '',
                    style: Theme.of(context).textTheme.caption?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 20.0,
                        ),
                  ),
                ],
              ),
            ),
    );
  }
}
