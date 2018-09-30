
import UIKit

class ViewController: UIViewController {
    
    let allQuestions = QuestionBank()
    var pickAnswer: Bool = false
    
    var questionNumber: Int = 0
    var score: Int = 0
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstQuestion = allQuestions.list[questionNumber]
        questionLabel.text = firstQuestion.questionText
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1 {
            pickAnswer = true
        }else if sender.tag == 2 {
            pickAnswer = false
        }
        checkAnswer()
        questionNumber = questionNumber + 1
        nextQuestion()
    }
    
    
    func updateUI() {
        scoreLabel.text = "Score\(score)"
        progressLabel.text = "Question Number\(questionNumber + 1) / 13"
        progressLabel.frame.size.width = (view.frame.size.width / 13) * CGFloat(questionNumber)
    }

    func startOver() {
        score = 0
        questionNumber = 0
        nextQuestion()
    }
    

    func checkAnswer() {
        let correctAnswer = allQuestions.list[questionNumber].answer
        
        if correctAnswer == pickAnswer {
            ProgressHUD.showSuccess("You Right")
            score+=1
        }else{
            ProgressHUD.showError("Fall")
            
        }
        
    }

    func nextQuestion() {
        if questionNumber <= 12 {
        questionLabel.text = allQuestions.list[questionNumber].questionText
        updateUI()
        }else{
            let alert = UIAlertController(title: "Good", message: "you are Done", preferredStyle: .alert)
            
            let restartAction = UIAlertAction(title: "Rest", style: .default , handler: {UIAlertAction in
                self.startOver()
            })
            alert.addAction(restartAction)
            present(alert,animated: true,completion: nil)
            }
        }
}
