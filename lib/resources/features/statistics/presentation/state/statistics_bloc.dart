import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../complaints/domain/entities/complaint_entity.dart';

part 'statistics_events.dart';

part 'statistics_states.dart';

class StatisticsBloc extends Bloc<StatisticsEvents, StatisticsStates> {
  StatisticsBloc() : super(StatisticsInitial()) {
    on<TotalComplaintsEvent>(_totalComplaints);
    on<PendingComplaintsEvent>(_pendingComplaints);
    on<ApprovedComplaintsEvent>(_approvedComplaints);
    on<RejectedComplaintsEvent>(_rejectedComplaints);
    on<ProcessingComplaintsEvent>(_processingComplaints);
  }


  void _totalComplaints(
    TotalComplaintsEvent event,
    Emitter<StatisticsStates> emit,
  ) {
    emit(TotalComplaints(complaints: event.complaints));
  }

  void _pendingComplaints(
    PendingComplaintsEvent event,
    Emitter<StatisticsStates> emit,
  ) {
    final pendingComplaints =
        event.complaints.where((complaint) => complaint.statusId == 1).toList();
    emit(PendingComplaints(complaints: pendingComplaints));
  }

  void _processingComplaints(
    ProcessingComplaintsEvent event,
    Emitter<StatisticsStates> emit,
  ) {
    final processingComplaints =
        event.complaints.where((complaint) => complaint.statusId == 2).toList();
    emit(ProcessingComplaints(complaints: processingComplaints));
  }

  void _rejectedComplaints(
      RejectedComplaintsEvent event,
      Emitter<StatisticsStates> emit,
      ) {
    final rejectedComplaints =
    event.complaints.where((complaint) => complaint.statusId == 3).toList();
    emit(RejectedComplaints(complaints: rejectedComplaints));
  }

  void _approvedComplaints(
    ApprovedComplaintsEvent event,
    Emitter<StatisticsStates> emit,
  ) {
    final approvedComplaints =
        event.complaints.where((complaint) => complaint.statusId == 4).toList();
    emit(ApprovedComplaints(complaints: approvedComplaints));
  }


}
