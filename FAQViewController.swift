//
//  FAQViewController.swift
//  ThinkInsideTheBun
//
//  Created by Alek Miller
//  Copyright © 2019 Danny Pham. All rights reserved.
//

import UIKit

var qAnswer: [String] = []
var questions: [String] = []
var myIndex = 0

class FAQViewController: UIViewController
{
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    
        questions = createQuestionsArray()
        qAnswer = createAnswersArray()
    }
    
    //creats an array for questions for the FAQ PAGE.
    func createQuestionsArray() -> [String]
    {
        var tempQuestions: [String] = []
        
        let question1:  String = "What type of events does \nThink Inside The Bun cater?"
        let question2:  String = "What are the minimum \ncosts for service?"
        let question3:  String = "Can my order have custom \nspecial requests?"
        let question4:  String = "What is the minimum deposit\nfor placing an order?"
        let question5:  String = "What is the policy for \ncancellations?"
        let question6:  String = "Are prices different outside \nof Stockton, CA?"
        let question7:  String = ""
        let question8:  String = ""
        let question9:  String = ""
        let question10: String = ""
        
        tempQuestions.append(question1)
        tempQuestions.append(question2)
        tempQuestions.append(question3)
        tempQuestions.append(question4)
        tempQuestions.append(question5)
        tempQuestions.append(question6)
        tempQuestions.append(question7)
        tempQuestions.append(question8)
        tempQuestions.append(question9)
        tempQuestions.append(question10)
        
        return tempQuestions
    }
    
    func createAnswersArray() -> [String]
    {
        var tempanswers: [String] = []
        
        let answer1:  String = "We specialize in Birthdays, Corporate Events, Picnics, Fundraisers, Graduations, Parties."
        let answer2:  String = "The minimum price is \n$200 for a catering event"
        let answer3:  String = "Yes. We are very flexible with custom orders.\nOur goal is to make sure our customers needs are fully met."
        let answer4:  String = "We require a 50% deposit after the catering request form has been finalized."
        let answer5:  String = "Please provide a 24 hour notice for cancellations. Parties who don't cancel in a timely manner may not have deposit refunded."
        let answer6:  String = "Depending on location, prices may be higher regards to travel time and fuel costs."
        let answer7:  String = ""
        let answer8:  String = ""
        let answer9:  String = ""
        let answer10: String = ""
        
        tempanswers.append(answer1)
        tempanswers.append(answer2)
        tempanswers.append(answer3)
        tempanswers.append(answer4)
        tempanswers.append(answer5)
        tempanswers.append(answer6)
        tempanswers.append(answer7)
        tempanswers.append(answer8)
        tempanswers.append(answer9)
        tempanswers.append(answer10)
        
        return tempanswers
    }
    
}


extension FAQViewController: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let question = questions[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "questionCell") as! FAQTableViewCell
        
        cell.setQuestiion(question: question)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        myIndex = indexPath.row
        performSegue(withIdentifier: "FAQSegue", sender: self)
        print("this is the index: \(myIndex)")
    }
    
}
