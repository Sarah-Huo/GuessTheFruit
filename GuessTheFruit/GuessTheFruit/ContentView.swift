//
//  ContentView.swift
//  GuessTheFruit
//
//  Created by Huo, Sarah Z on 2/21/24.
//

import SwiftUI
import AVFAudio
struct ContentView: View {
    @State private var words =  ["apple", "banana", "blueberry", "mango", "cherry"]
    @State private var image = "fimage0"
    @State private var word = "apple"
    
    @State private var name  = ""
    @State private var text = ""
    @State private var buttonText = "Enter"
    @State private var playAgain = false
    @State var audioPlayer: AVAudioPlayer!
    
    @State private var numGuesses = 0
    @State private var last = 0
    
    var body: some View {
        VStack {
            Spacer()
            Text("Guess the fruit!")
                .font(.largeTitle)
                .fontWeight(.light)
                .padding()
            
            Image(image)
                .resizable()
                .scaledToFit()
                .animation(.easeIn, value: image)
            
            Text(text)
                .fontWeight(.regular)
                .padding()
            
            Text("Number of Guesses: \(numGuesses)")
                .fontWeight(.regular)
                .italic()
                .padding()
            
            TextField("Enter a fruit name", text: $name)
                .textFieldStyle(.roundedBorder)
            
            Button(buttonText) {
                
                if(playAgain){
                    buttonText = "Enter"
                    last = randomFruit(lastNumber: last)
                    word = words[last]
                    image = "fimage\(last)"
                    numGuesses = 0
                    playAgain = false;
                    
                }else{
                    if (name == "") {
                        text = "Please enter your guess."
                    }
                    else if (name.lowercased() == word) {
                        text = "You guessed it! The fruit was: \(word)"
                        name = ""
                        numGuesses+=1
                        //Fill in fruit
                        image = "image\(last)"
                        playSound(soundNumber: 1)
                        
                        
                        
                        //Change button
                        buttonText = "Play Again?"
                        playAgain = true
                        //Sounds & Update Score
                        //Then change fruit
                        
                        
                    } else if(numGuesses<3) {
                        text = "\(name) is incorrect, try again :("
                        numGuesses+=1
                        playSound(soundNumber: 2)
                        
                        
                    } else{
                        //playSound(soundNumber: 0)
                        text = "None of those guesses were right :( \n          The fruit was: \(word)"
                        name = ""
                        //Fill in fruit
                        image = "image\(last)"
                        playSound(soundNumber: 0)
                        
                        
                        
                        //Change button
                        buttonText = "Play Again?"
                        playAgain = true
                        //Sounds & Update Score
                        //Then change fruit
                    }
                    
                    
                    
                }
                
                func randomFruit(lastNumber: Int) -> Int{
                    var number: Int
                    repeat {
                        number = Int.random(in: 0...words.count-1)
                    } while number == lastNumber
                    return number
                }
                func playSound(soundNumber: Int){
                    var soundName = "sound\(soundNumber)"
                    
                    
                    guard let soundFile = NSDataAsset(name: soundName) else {
                        print("😡 Could not read file named \(soundName)")
                        return
                    }
                    do {
                        audioPlayer = try AVAudioPlayer(data: soundFile.data)
                        audioPlayer.play()
                    }catch{
                        print("😡 ERROR:\(error.localizedDescription) creating audioPlayer.")
                    }
                }
            }
            
            Spacer()
        }
        .padding()
        .buttonStyle(.borderedProminent)
        .tint(.cyan)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

