//
//  MapCell.swift
//  Venga
//
//  Created by David Richards on 7/22/17.
//  Copyright © 2017 David Richards. All rights reserved.
//

import UIKit
import MapKit
import SnapKit
import ChameleonFramework

class MapCell: UITableViewCell, MKMapViewDelegate {
    
    let map = MKMapView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Setup the delegate
        self.map.delegate = self
        
        // Make the select color none
        self.selectionStyle = .none
        self.backgroundColor = .clear
        
        // size the map to the same size as the cell
        self.contentView.addSubview(self.map)
        self.map.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(self.contentView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func addAnnotation(lat: Float, lng: Float) {
        let annotation = MKPointAnnotation()
        annotation.coordinate.latitude = CLLocationDegrees(lat)
        annotation.coordinate.longitude = CLLocationDegrees(lng)
        self.map.addAnnotation(annotation)
        self.map.showAnnotations(self.map.annotations, animated: true)
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if !(annotation is MKPointAnnotation) {
            return nil
        }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "demo")
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "demo")
            annotationView!.canShowCallout = true
        }
        else {
            annotationView!.annotation = annotation
        }
        
        // Add custom annotation
        if let annotationView = annotationView {
            annotationView.image = UIImage.fontAwesomeIcon(name: .mapMarker, textColor: FlatMint(), size: CGSize(width: 50, height: 50))
        }
        return annotationView
    }
}

