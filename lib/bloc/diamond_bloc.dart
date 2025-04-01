import 'package:flutter_bloc/flutter_bloc.dart';
import '../data.dart';
import '../models/diamond.dart';
import 'diamond_event.dart';
import 'diamond_state.dart';

class DiamondBloc extends Bloc<DiamondEvent, DiamondState> {
  List<Diamond> _allDiamonds = []; // Store the full list for filtering

  DiamondBloc() : super(DiamondInitial()) {
    on<LoadDiamonds>((event, emit) async {
      emit(DiamondLoading());
      try {
        _allDiamonds = await loadDiamonds();
        emit(DiamondLoaded(diamonds: _allDiamonds));
      } catch (e) {
        emit(DiamondError(message: e.toString()));
      }
    });

    on<FilterDiamonds>((event, emit) async {
      emit(DiamondLoading()); // Show loading state while filtering
      try {
        List<Diamond> filtered = _allDiamonds.where((diamond) {
          bool matchesCarat = diamond.carat >= event.caratFrom && diamond.carat <= event.caratTo;
          bool matchesLab = event.lab.isEmpty || diamond.lab == event.lab;
          bool matchesShape = event.shape.isEmpty || diamond.shape == event.shape;
          bool matchesColor = event.color.isEmpty || diamond.color == event.color;
          bool matchesClarity = event.clarity.isEmpty || diamond.clarity == event.clarity;
          return matchesCarat && matchesLab && matchesShape && matchesColor && matchesClarity;
        }).toList();

        if (event.sortBy != null) {
          filtered.sort((a, b) {
            if (event.sortBy == 'priceAsc') return a.finalAmount.compareTo(b.finalAmount);
            if (event.sortBy == 'priceDesc') return b.finalAmount.compareTo(a.finalAmount);
            if (event.sortBy == 'caratAsc') return a.carat.compareTo(b.carat);
            if (event.sortBy == 'caratDesc') return b.carat.compareTo(a.carat);
            return 0;
          });
        }

        emit(DiamondLoaded(diamonds: filtered));
      } catch (e) {
        emit(DiamondError(message: e.toString()));
      }
    });
  }
}