//
//  ExperienceBuilder.swift
//  Venga
//
//  Created by David Richards on 8/6/17.
//  Copyright © 2017 David Richards. All rights reserved.
//

import UIKit
import Eureka
import Dollar
import MapKit
import TTGSnackbar

class ExperienceEditor: FormViewController {
    
    let backend = Backend.sharedClient
    let loading = Loading()
    let alerter = Alerter()
    let snackbar = TTGSnackbar.init(message: "Message", duration: .middle)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = GlobalConst.backgroundColor

        form +++ Section("Details")
            <<< TextRow() {
                $0.title = "Title"
                $0.placeholder = "Enter title here"
                $0.tag = "title"
            }
            <<< DecimalRow(){
                $0.title = "Price"
                $0.placeholder = "Enter price here"
                $0.tag = "price"
            }
            <<< IntRow() {
                $0.title = "Max Group Size"
                $0.placeholder = "Enter max group size here"
                $0.tag = "group_size"
            }
            <<< IntRow() {
                $0.title = "Age Requirement"
                $0.placeholder = "Enter minimum age here"
                $0.tag = "age_requirement"
            }
            <<< TextRow() {
                $0.title = "Experience Style"
                $0.placeholder = "Enter the style of experience in one word"
                $0.tag = "style"
            }
            <<< SliderRow() {
                $0.title = "Physical Rating"
                $0.maximumValue = 10
                $0.minimumValue = 0
                $0.tag = "physical_rating"
            }
            <<< SliderRow() {
                $0.title = "Hours in total"
                $0.maximumValue = 10
                $0.minimumValue = 0
                $0.tag = "hours"
            }
        +++ Section("Description")
            <<< TextAreaRow(){
                $0.tag = "description"
                $0.title = "Desciption"
                $0.placeholder = "Enter description here"
            }
        +++ Section("Itinerary")
            <<< TextAreaRow() {
                $0.tag = "itinerary"
                $0.title = "Itinerary"
                $0.placeholder = "Enter itinerary info here"
            }
        +++ MultivaluedSection(multivaluedOptions: [.Reorder, .Insert, .Delete],
               header: "Images",
               footer: "The first image in the list will be used as the featured image") {
               $0.addButtonProvider = { section in
                    return ButtonRow(){
                        $0.title = "Add image"
                    }
                }
                $0.multivaluedRowToInsertAt = { index in
                    return ImageRow() {
                        $0.title = "Image"
                        $0.tag = "image\(index)"
                    }
                }
                $0 <<< ImageRow() {
                    $0.title = "Image"
                    $0.tag = "image0"
                }
        }
        +++ MultivaluedSection(multivaluedOptions: [.Reorder, .Insert, .Delete],
                               header: "Offered in these languages",
                               footer: "") {
                                $0.addButtonProvider = { section in
                                    return ButtonRow(){
                                        $0.title = "Add language"
                                    }
                                }
                                $0.multivaluedRowToInsertAt = { index in
                                    return TextRow() {
                                        $0.title = "Language"
                                        $0.tag = "language\(index)"
                                    }
                                }
                                $0 <<< TextRow() {
                                    $0.title = "Language"
                                    $0.tag = "language0"
                                }
        }
        +++ MultivaluedSection(multivaluedOptions: [.Reorder, .Insert, .Delete],
                               header: "What is included in the experience",
                               footer: "It is nice to include things like transportation, lunch, or drinks in this section so guest know what to expect.") {
                                $0.addButtonProvider = { section in
                                    return ButtonRow(){
                                        $0.title = "Add included"
                                    }
                                }
                                $0.multivaluedRowToInsertAt = { index in
                                    return TextRow() {
                                        $0.title = "Included"
                                        $0.tag = "inlcuded\(index)"
                                    }
                                }
                                $0 <<< TextRow() {
                                    $0.title = "Included"
                                    $0.tag = "included0"
                                }
        }
        +++ Section("Location")
            <<< LocationRow() {
                $0.title = "Location"
                $0.tag = "location"
        }
        +++ Section("")
            <<< ButtonRow() {
                $0.title = "Submit"
            }.onCellSelection { (cell, row) in
                self.submit()
            }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func submit() {
        
        let values = form.values()
        
        print(values)
        
        // Get Details
        if (!Helpers.validateExperience(values: values)) {
            self.alerter.error("All rows must be filled out", view: self.view)
            self.loading.stop()
            return
        }
        
        // Start spinner after validation
        self.loading.start(view: self.view)
        
        // Get the experience location
        let location = values["location"] as! CLLocation
        
        // Get the included items
        let included = values.filter({ key, value in
            return key.lowercased().range(of: "included") != nil
        }).map { included in
            return included.value
        }
        
        // Get the languages given
        let languages = values.filter({ key, value in
            return key.lowercased().range(of: "language") != nil
        }).map { language in
            return language.value
        }
        
        var experienceDict = [
            "title": values["title"]!,
            "headline": values["headline"]!,
            "itinerary": values["itinerary"]!,
            "price": values["price"]!,
            "destination_id": "tbd",
            "details": [
                "style": values["style"]!,
                "physical_rating": values["physical_rating"]!,
                "age_requirement": values["age_requirement"]!,
                "group_size": values["group_size"]!,
                "hours": values["hours"]!,
            ],
            "location": [
                "lat": location.coordinate.latitude,
                "lng": location.coordinate.longitude,
            ],
            "included": included,
            "languages": languages,
        ]
        
        // Get the images
        var imageKeys: [String] = []
        var imageMap: [String: UIImage] = [:]
        
        values.filter({ key, value in
            return key.lowercased().range(of: "image") != nil
        }).forEach { obj in
            imageKeys.append(obj.key)
            imageMap[obj.key] = obj.value as? UIImage
        }
        
        self.backend.getPresignedUrls(titles: imageKeys) { uploadImages, error in
            if let error = error {
                NSLog(error.localizedDescription)
                self.alerter.error("Error uploading images", view: self.view)
                self.loading.stop()
                return
            }
            if let uploadImages = Helpers.connetImagesToTitle(imageMap: imageMap, uploadImages: uploadImages!) {
                self.backend.uploadS3Images(images: uploadImages) { imagesDictArray, error in
                    self.loading.stop()
                    if let error = error {
                        NSLog(error.localizedDescription)
                        self.alerter.error("Error uploading images", view: self.view)
                        return
                    }
                    experienceDict["images"] = imagesDictArray
                    
                    // Create the experience on the server
                    NSLog("Creating the experience")
                    self.backend.createExperience(experience: experienceDict) { error in
                        if let error = error {
                            NSLog(error.localizedDescription)
                            self.alerter.error("There was an error creating your experience", view: self.view)
                            return
                        }
                        self.snackbar.message = "Successfully created new experience"
                        self.snackbar.show()
                        // Pop back to the main page after short delay. This give the user time to see the success message.
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                    
                }
            }
        }
    }

}
