//
//  NetworkManager.swift
//  HackChallengeSP22
//
//  Created by Abigail Castro on 5/3/22.
//

import Alamofire
import Foundation

class NetworkManager {
    static let host = "http://34.130.0.202"

    
    //Functions for authentication
    static func postRegister(first_name: String, username: String, password: String, completion: @escaping (LoginResponse) -> Void) {
        let endpoint = "\(host)/api/register/"
        let parameters: [String: String] = [
            "first_name": first_name,
            "username": username,
            "password": password
        ]
        AF.request(endpoint, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default).validate().responseData { response in
            switch (response.result) {
            case .success(let data):
                print(data)
                let jsonDecoder = JSONDecoder()
                if let userResponse = try? jsonDecoder.decode(LoginResponse.self, from: data) {
                    completion(userResponse)
                } else {
                    print("Failed to decode postRegister")
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func postLogin(username: String, password: String, completion: @escaping (LoginResponse) -> Void) {
        let endpoint = "\(host)/api/login/"
        let parameters: [String: String] = [
            "username": username,
            "password": password
        ]
        AF.request(endpoint, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default).validate().responseData { response in
            switch (response.result) {
            case .success(let data):
                print(data)
                let jsonDecoder = JSONDecoder()
                if let userResponse = try? jsonDecoder.decode(LoginResponse.self, from: data) {
                    completion(userResponse)
                } else {
                    print("Failed to decode postLogin")
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func postLogout(sessionToken: String, completion: @escaping (LogoutResponse) -> Void) {
        let endpoint = "\(host)/api/logout/"
        let headers: HTTPHeaders = [
            .authorization(bearerToken: sessionToken)]
        AF.request(endpoint, method: .post, headers: headers).validate().responseData { response in
            switch (response.result)
            {
            case .success(let data):
                print("hi", data)
                let jsonDecoder = JSONDecoder()
                if let userResponse = try? jsonDecoder.decode(LogoutResponse.self, from: data) {
                    completion(userResponse)
                } else {
                    print("Failed to decode postLogout")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func postRefresh(updateToken: String, completion: @escaping (LoginResponse) -> Void) {
        let endpoint = "\(host)/api/session/"
        let headers: HTTPHeaders = [
            .authorization(bearerToken: updateToken)]
        AF.request(endpoint, method: .post, headers: headers).validate().responseData { response in
            switch (response.result)
            {
            case .success(let data):
                print("hello", data)
                let jsonDecoder = JSONDecoder()
                if let userResponse = try? jsonDecoder.decode(LoginResponse.self, from: data) {
                    completion(userResponse)
                } else {
                    print("Failed to decode postRefresh")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //Function for tasks
    static func getTasks(sessionToken: String, completion: @escaping (Tasks) -> Void) {

        let endpoint = "\(host)/api/tasks/"
        let headers: HTTPHeaders = [
            .authorization(bearerToken: sessionToken)]

        AF.request(endpoint, method: .get, headers: headers).validate().responseData { response in
            switch (response.result)
            {
            case .success(let data):
                print("getting tasks", data)
                let jsonDecoder = JSONDecoder()
                if let userResponse = try? jsonDecoder.decode(Tasks.self, from: data) {
                    print(userResponse)
                    completion(userResponse)
                } else {
                    print("Failed to decode getTasks")
                }
            case .failure(let error):
                print(error.localizedDescription)
                        }
        }
        }
    
    static func createTask(sessionToken: String, taskName: String, dueDate: Int, completed: Bool, priority: Int, completion: @escaping (Task) -> Void) {

        let endpoint = "\(host)/api/tasks/"
        let headers: HTTPHeaders = [
            .authorization(bearerToken: sessionToken)]

        let parameters = Task(task_name: taskName, due_date: dueDate, completed: completed, priority: priority)

        let jsonEncoder = JSONEncoder()
        jsonEncoder.dateEncodingStrategy = .secondsSince1970

        AF.request(endpoint, method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: headers).validate().responseData { response in
            switch (response.result)
            {
            case .success(let data):
                print("creating Task", data)
                let jsonDecoder = JSONDecoder()
                if let userResponse = try? jsonDecoder.decode(Task.self, from: data) {
                    completion(userResponse)
                } else {
                    print("Failed to decode createTask")
                }
            case .failure(let error):
                print(error.localizedDescription)
                        }
        }
        }
    
    static func completeTask(sessionToken: String, id: Int, completed: Bool, completion: @escaping (Task) -> Void) {

        let endpoint = "\(host)/api/tasks/\(id)/"
        let headers: HTTPHeaders = [
            .authorization(bearerToken: sessionToken)]

        let parameters: [String: Bool] = ["completed": completed]

        AF.request(endpoint, method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: headers).validate().responseData { response in
            switch (response.result)
            {
            case .success(let data):
                print(completed)
                print("completing Task", data)
                let jsonDecoder = JSONDecoder()
                if let userResponse = try? jsonDecoder.decode(Task.self, from: data) {
                    print(userResponse)
                    completion(userResponse)
                } else {
                    print("Failed to decode completeTask")
                }
            case .failure(let error):
                print(error.localizedDescription)
                        }
        }
        }
    //Functions for events
    static func getEvents(sessionToken: String, completion: @escaping (Events) -> Void) {

        let endpoint = "\(host)/api/events/"
        let headers: HTTPHeaders = [
            .authorization(bearerToken: sessionToken)]

        AF.request(endpoint, method: .get, headers: headers).validate().responseData { response in
            switch (response.result)
            {
            case .success(let data):
                print("getting events", data)
                let jsonDecoder = JSONDecoder()
                if let userResponse = try? jsonDecoder.decode(Events.self, from: data) {
                    print(userResponse)
                    completion(userResponse)
                } else {
                    print("Failed to decode getEvents")
                }
            case .failure(let error):
                print(error.localizedDescription)
                        }
        }
        }
    
    static func createEvent(sessionToken: String, eventName: String, description: String, startTime: Int, endTime: Int, color: String, location: String, completion: @escaping (Event) -> Void) {

        let endpoint = "\(host)/api/events/"
        let headers: HTTPHeaders = [
            .authorization(bearerToken: sessionToken)]

        let parameters = Event(event_name: eventName, description: description, start_time: startTime, end_time: endTime, color: color, location: location)

        let jsonEncoder = JSONEncoder()
        jsonEncoder.dateEncodingStrategy = .secondsSince1970

        AF.request(endpoint, method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: headers).validate().responseData { response in
            switch (response.result)
            {
            case .success(let data):
                print("creating Event", data)
                let jsonDecoder = JSONDecoder()
                if let userResponse = try? jsonDecoder.decode(Event.self, from: data) {
                    completion(userResponse)
                } else {
                    print("Failed to decode createEvent")
                }
            case .failure(let error):
                print(error.localizedDescription)
                        }
        }
        }
}
