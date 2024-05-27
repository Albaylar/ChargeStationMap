//
//  ZoomObserver.swift
//  ChargeStationMap
//
//  Created by Furkan Deniz Albaylar on 18.03.2024.
//
import MapKit

class ZoomObserver: NSObject, MKMapViewDelegate {
  
  @Binding var isFetchingData: Bool
  let viewModel: ChargeViewModel
  
  init(viewModel: ChargeViewModel, isFetchingData: Binding<Bool>) {
    self.viewModel = viewModel
    self._isFetchingData = isFetchingData
  }
  
  func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
    guard !isFetchingData else { return } // Avoid unnecessary fetches
    
    let newZoomLevel = mapView.zoomLevel
    
    // Trigger data fetching based on zoom level (zoom out)
    if newZoomLevel < viewModel.previousZoomLevel {
      isFetchingData = true
      viewModel.fetchDataForCurrentRegion()
    }
    
    viewModel.previousZoomLevel = newZoomLevel
  }
}

