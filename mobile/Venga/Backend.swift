//
//  Backend.swift
//  Venga
//
//  Created by David Richards on 4/29/17.
//  Copyright © 2017 David Richards. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import Stripe
import FacebookCore

class Backend: NSObject, STPBackendAPIAdapter {
    
    static let sharedClient = Backend()
    var headers: HTTPHeaders = HTTPHeaders()
    let cache = Cache.sharedInstance
    
    func retrieveCustomer(_ completion: @escaping STPCustomerCompletionBlock) {
        
        Alamofire.request(GlobalConst.stripeUrl, headers: self.headers).validate().response { response in
            let deserializer = STPCustomerDeserializer(data: response.data, urlResponse: response.response, error: response.error)
            if let error = deserializer.error {
                NSLog(error.localizedDescription)
                completion(nil, error)
                return
            } else if let customer = deserializer.customer {
                completion(customer, nil)
            }
        }
    }
    
    func selectDefaultCustomerSource(_ source: STPSource, completion: @escaping STPErrorBlock) {
        
        // set the stripe id as source in params
        let params = ["source": source.stripeID,]
        
        NSLog("Trying to get set Stripe default customer source")
        
        Alamofire.request(GlobalConst.stripeUrlDefaultSource, method: .post, parameters: params, encoding: JSONEncoding.default, headers: self.headers).validate().responseJSON { response in
            switch response.result {
            case .success(_):
                completion(nil)
            case .failure(let error):
                NSLog(error.localizedDescription)
                completion(error)
            }
        }
    }
    
    func attachSource(toCustomer source: STPSource, completion: @escaping STPErrorBlock) {
        
        // set the stripe id as source in params
        let params = ["source": source.stripeID]
        
        NSLog("Trying to attach source")
        Alamofire.request(GlobalConst.stripeUrlSources, method: .post, parameters: params, encoding: JSONEncoding.default, headers: self.headers).validate().responseJSON { response in
            switch response.result {
            case .success(_):
                NSLog("Success")
                completion(nil)
            case .failure(let error):
                NSLog(error.localizedDescription)
                completion(error)
            }
        }
    }
    
    func completeCharge(_ result: STPPaymentResult, amount: Int, completion: @escaping (Any?, Error?) -> ()) {
        
        // set the stripe params
        let params: [String: AnyObject] = [
            "source": result.source.stripeID as AnyObject,
            "amount": amount as AnyObject
            ]
        
        NSLog("Completing charge api request")
        
        Alamofire.request(GlobalConst.stripeUrlCharge, method: .post, parameters: params, encoding: JSONEncoding.default, headers: self.headers).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                NSLog("Successful charge")
                completion(value, nil)
            case .failure(let error):
                NSLog(error.localizedDescription)
                completion(nil, error)
            }
        }
    }
    
    func getCharges(completion: @escaping ([StripeTransaction]?, Error?) -> ()) {
        
        Alamofire.request(GlobalConst.stripeUrlCharges, headers: self.headers).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let transactions = json["data"].arrayValue.map { transaction in
                    StripeTransaction(id: transaction["id"].stringValue, status: transaction["status"].stringValue, amount: transaction["amount"].floatValue / 100, created: transaction["created"].stringValue)
                }
                print(JSON(value))
                
                completion(transactions, nil)
            case .failure(let error):
                NSLog(error.localizedDescription)
                completion(nil, error)
            }
        }
    }
    
    func stripeOauthToken(client_secret: String, code: String, completion: @escaping (JSON, Error?) -> ()) {
        
        let params: [String: String] = [
            "client_secret": client_secret,
            "code": code,
            "grant_type": "authorization_code",
        ]
        
        Alamofire.request(GlobalConst.stripeOauthTokenUrl, method: .post, parameters: params, encoding: URLEncoding.default).validate().responseJSON() { response in
            switch response.result {
            case .success(let value):
                // convert to json
                let json = JSON(value)
                // return the user object
                completion(json, nil)
            case .failure(let error):
                NSLog(error.localizedDescription)
                completion(nil, error)
            }
        }
    }
    
    func signupHost(stripeHost: StripeHost, completion: @escaping (Error?) -> ()) {
        NSLog("Trying to create host")
        Alamofire.request(GlobalConst.hostUrl, method: .post, parameters: stripeHost.toDict(), encoding: JSONEncoding.default, headers: self.headers).validate().responseJSON { response in
            switch response.result {
            case .success(_):
                completion(nil)
            case .failure(let error):
                NSLog(error.localizedDescription)
                completion(error)
            }
        }
    }
    
    func reset(_
               newPassword: String,
               currentPassword: String,
               completion: @escaping (Error?) -> ()
               ){
        
        let params: Dictionary<String, String> = [
        "current_password": currentPassword,
        "new_password": newPassword
        ]
        
        Alamofire.request(GlobalConst.userResetUrl, method: .patch, parameters: params, encoding: JSONEncoding.default, headers: self.headers).validate().responseJSON { response in
            switch response.result {
            case .success(_):
               completion(nil)
            case .failure(let error):
                NSLog(error.localizedDescription)
                completion(error)
            }
        }
    }

    
    func login(_ email: String?,
               password: String?,
               completion: @escaping (UserModel?, Error?) -> ()
        ){
        
        // initialize the param dict
        var params = Dictionary<String, String>()
        
        NSLog("Trying to login")
        
        // add the facebook token if the user logged in with facebook
        if (Realm().loginType() == "facebook") {
            if AccessToken.current != nil {
                if let token: String = AccessToken.current?.authenticationToken {
                    NSLog(token)
                    params["facebookToken"] = token
                }
            }
        }
        
        if let emailText = email, let passwordText = password {
            params["email"] = emailText
            params["password"] = passwordText
        }
        
        // make the request with custom params if they are entered
        Alamofire.request(GlobalConst.userLoginUrl, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                print("Successful login")
                // set the headers for the backend api
                self.headers = ["Authorization": json["token"].stringValue]
                // save the token to the userdata store
                Realm().saveToken(json["token"].stringValue)
                
                // return the user object
                completion(UserModel(json: json), nil)
            case .failure(let error):
                NSLog(error.localizedDescription)
                completion(nil, error)
            }
            
        }
    }
    
    func singup(firstname: String,
                lastname: String,
                email: String,
                password: String,
                completion: @escaping (Any?, Error?) -> ()
        ) {
        NSLog("Trying to singup with \(email)")
        
        let params: Dictionary<String, String> = [
            "firstname": firstname,
            "lastname": lastname,
            "email": email,
            "password": password
        ]
        
        Alamofire.request(GlobalConst.userSignupUrl, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                // return the user object
                completion(value, nil)
            case .failure(let error):
                NSLog(error.localizedDescription)
                completion(nil, error)
            }
            
        }
        
    }
    
    func getUser(completion: @escaping (UserModel?, Error?) -> ()) {
        // make the api request to get the user profile
        Alamofire.request(GlobalConst.userMeUrl, headers: self.headers).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                // convert to json
                let json = JSON(value)
                // return the user object
                completion(UserModel(json: json), nil)
            case .failure(let error):
                NSLog(error.localizedDescription)
                completion(nil, error)
            }
            
        }
    }
    
    func getDestinations(completion: @escaping ([Destination]?, Error?) -> ()) {
        // make the api request to get the destinations
        Alamofire.request(GlobalConst.destinationUrl, headers: self.headers).validate().responseJSON { response in
            print(response.value ?? "")
            switch response.result {
            case .success(let value):
                // convert to json
                let json = JSON(value)
                let destinationsJson = json.arrayValue
                let destinations = destinationsJson.map { destination in
                    Destination(title: destination["title"].stringValue, description: destination["description"].stringValue, id: destination["id"].stringValue, imageUrl: destination["imageUrl"].stringValue)
                }
                completion(destinations, nil)
            case .failure(let error):
                NSLog(error.localizedDescription)
                completion(nil, error)
            }
            
        }
    }
    
    func getExperiences(id: String, completion: @escaping ([Experience]?, Error?) -> ()) {
        
        // make the destination /destinations/{id}
        let url = [GlobalConst.destinationUrl, id].joined(separator: "/")
        
        Alamofire.request(url, headers: self.headers).validate().responseJSON { response in
            print(response.value ?? "")
            switch response.result {
            case .success(let value):
                // convert to json
                let json = JSON(value)
                // get the array value
                let experienceJson = json.arrayValue
                // map the response to an array of models
                let experiences = experienceJson.map { experience in

                    Experience(experience: experience)
                }
                completion(experiences, nil)
            case .failure(let error):
                NSLog(error.localizedDescription)
                completion(nil, error)
            }
        }
    }
    
    func createTrip(experienceId: String, destinationId: String, price: String, date: String, groupSize: Int, stripeResponse: Any, completion: @escaping (Any?, Error?) -> ()) {
        
        let params: Dictionary<String, Any> = [
            "destination_id": destinationId,
            "experience_id": experienceId,
            "price": price,
            "stripe_response": stripeResponse,
            "date": date,
            "group_size": groupSize,
            "status": "Pending"
        ]
        
        Alamofire.request(GlobalConst.tripsUrl, method: .post, parameters: params, encoding: JSONEncoding.default, headers: self.headers).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                // return the user object
                completion(value, nil)
            case .failure(let error):
                NSLog(error.localizedDescription)
                completion(nil, error)
            }
            
        }
        
    }
    
    func getTrips(completion: @escaping ([Trip]?, Error?) -> ()) {
        // make request to get all trips for this user
        NSLog("About to make the request")
        Alamofire.request(GlobalConst.tripsUrl, headers: self.headers).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                // convert to json
                let json = JSON(value)
                // get the array value
                let tripJson = json.arrayValue
                // map the response to an array of models
                let trips = tripJson.map { trip in
                    Trip(json: trip)
                }
                completion(trips, nil)
            case .failure(let error):
                NSLog(error.localizedDescription)
                completion(nil, error)
            }
        }
    }
    
    func getReviews(experienceId: String, completion: @escaping ([Review]?, Error?) -> ()) {
        let url = GlobalConst.reviewUrl + "/\(experienceId)"
        print("url: \(url)")
        Alamofire.request(url, headers: self.headers).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                // convert to json
                let json = JSON(value)
                // get the array value
                let reviewJson = json.arrayValue
                // map the response to an array of models
                let reviews = reviewJson.map { review in
                    Review(review: review)
                }
                completion(reviews, nil)
            case .failure(let error):
                NSLog(error.localizedDescription)
                completion(nil, error)
            }
        }
    }
    
    func getPresignedUrls(titles: [String], completion: @escaping ([UploadImage]?, Error?) -> ()) {
        let params: [String: Any] = [
            "titles": titles
        ]
        Alamofire.request(GlobalConst.imagesPreSignedUrls, method: .post, parameters: params, encoding: JSONEncoding.default, headers: self.headers).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                // return the user object
                let json = JSON(value)
                let uploadedImages = json.arrayValue.map { image in
                    return UploadImage(title: image["title"].stringValue, image: UIImage(), url: image["url"].stringValue, uploadUrl: image["uploadUrl"].stringValue)
                }
                completion(uploadedImages, nil)
            case .failure(let error):
                NSLog(error.localizedDescription)
                completion(nil, error)
            }
            
        }
    }
    
    func uploadS3Images(images: [UploadImage], completion: @escaping ([Dictionary<String, String>]?, Error?) -> ()) {
        
        let myGroup = DispatchGroup()
        var uploadedImages = [Dictionary<String, String>]()
        
        for image in images {
            myGroup.enter()
            
            // For some reason the content type has to be set to empty string to get the upload to work
            Alamofire.upload(UIImageJPEGRepresentation(image.image, 1.0)!, to: image.uploadUrl, method: .put, headers: ["Content-Type": ""])
                .uploadProgress { progress in // main queue by default
                    print("Upload Progress: \(progress.fractionCompleted)")
                }.validate().responseData { response in
                debugPrint(response)
                switch response.result {
                case .success(let value):
                    myGroup.leave()
                    print("SUCCESS \(value)")
                    uploadedImages.append(["title": image.title, "url": image.url])
                case .failure(let error):
                    myGroup.leave()
                    NSLog("FAILURE \(error.localizedDescription)")
                    completion(nil, error)
                }
            }
        }
        
        
        myGroup.notify(queue: DispatchQueue.main, execute: {
            print("Finished all requests.")
            completion(uploadedImages, nil)
        })
        
    }
    
    func createExperience(experience: [String: Any], completion: @escaping (Error?) -> ()) {
        NSLog("About to send the request")
        print(experience)
        Alamofire.request(GlobalConst.createExperienceUrl, method: .post, parameters: experience, encoding: JSONEncoding.default, headers: self.headers).validate().responseJSON { response in
            switch response.result {
            case .success(_):
                completion(nil)
            case .failure(let error):
                NSLog(error.localizedDescription)
                completion(error)
            }
        }
    }
    
    func getHostExperiences(completion: @escaping ([Experience]?, Error?) -> ()) {
        print(GlobalConst.hostExperiencesUrl)
        Alamofire.request(GlobalConst.hostExperiencesUrl, headers: self.headers).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                // convert to json
                let json = JSON(value)
                // get the array value
                let experiencesJson = json.arrayValue
                // map the response to an array of experience models
                let experiences = experiencesJson.map { experience in
                    Experience(experience: experience)
                }
                completion(experiences, nil)
            case .failure(let error):
                NSLog(error.localizedDescription)
                completion(nil, error)
            }
        }
    }
    
    func getHost(hostId: String, completion: @escaping (Host?, Error?) -> ()) {
        
        Alamofire.request("\(GlobalConst.hostUrl)/\(hostId)" , headers: self.headers).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                // convert to json
                let json = JSON(value)
                print(json)
                let host = Host(name: "\(json["firstname"].stringValue) \(json["lastname"].stringValue)", title: json["host_title"].stringValue, imageUrl: json["imageUrl"].stringValue, description: json["host_description"].stringValue)
                completion(host, nil)
            case .failure(let error):
                NSLog(error.localizedDescription)
                completion(nil, error)
            }
        }
    }
    
}
