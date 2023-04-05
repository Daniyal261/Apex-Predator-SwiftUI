//
//  PredatorDetailsView.swift
//  Apex Predators
//
//  Created by Raja Adeel Ahmed on 4/5/23.
//

import SwiftUI

struct PredatorDetailsView: View {
    let predator: ApexPredatorModel!
    let predatorDetailController = PredatorDetailController()
    @State var isPlaying = false
    var body: some View {

       return ScrollView {
            VStack(alignment: .trailing) {
                Image(predator.type)
                    .resizable()
                    .scaledToFit()
                Image(predator.name.lowercased().filter {$0 != " "})
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width / 1.5, height: UIScreen.main.bounds.height / 4)
                    .shadow(color: .black, radius: 6, x: 0, y: 0)
                    .offset(y:-210)
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y:1, z:0 ))
                
                VStack(alignment: .leading) {
                    HStack {
                        Text(predator.name)
                            .font(.largeTitle)
                            .padding(.bottom, 8)
                        
                        Button{
                                predatorDetailController.playSound(String(predator.name.prefix(while: { $0 != " " })))
                            isPlaying.toggle()
                            
                        } label: {
                            Image(systemName:  !isPlaying ? "play" : "pause")
                                .frame(width: 40, height: 40)
                        }
                        .background(predator.typeOverLay())
                        .cornerRadius(20)
                        
                    }
                    
                    Text(predator.intro)
                        .font(.title3)
                        .padding(.bottom, 1)
                    
                    Text("Appears In:")
                        .font(.title3)
                    
                    ForEach(predator.movies, id: \.self) { movie in
                        Text("•" + movie)
                    }
                    
                    Text("Movie Momments:")
                        .font(.title)
                        .padding(.top, 15)
                    
                    ForEach(predator.movieScenes) { scene in
                        
                        Text(scene.movie)
                            .font(.title2)
                            .padding([.top, .bottom], 1)
                        
                        Text(scene.sceneDescription)
                            .padding(.bottom ,15)
                    }
                    
                    Text("Read More:")
                        .font(.caption)
                    Link(predator.link,destination: URL(string: predator.link)!)
                    
                }
                .padding(.top, -230)
                .padding()
            }
        }
        .edgesIgnoringSafeArea(.top)
        .onDisappear {
            predatorDetailController.audioPlayer?.stop()
        }
        .onAppear {
            predatorDetailController.speak(predator.name)
        }
    }
}

struct PredatorDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let movieScene1 = MovieSceneModel(id: 1, movie: "Jurassic Park", sceneDescription: "The Brachiosaurus was the first dinosaur encountered by the endorsement team hired by InGen to make sure Jurassic Park was safe for visitors. The entire team was amazed. Dr. Alan Grant and Dr. Ellie Sattler were the most awestruck of the group because the Brachiosaurus was terrestrial, not semi-aquatic swamp dwellers they had thought they were.\n\nWhen Dennis Nedry disabled Jurassic Park's security systems, the security fences that kept the prehistoric animals from escaping their enclosures were disabled as well, Brachiosaurus was one of the dinosaurs that were able to roam freely.\n\nAfter fleeing from the Tyrannosaur Paddock, Dr. Alan Grant and Tim and Lex Murphy climbed a tree where saw a herd of Brachiosaurus feeding on the nearby trees, hooting in the distance. Dr. Alan Grant heard their calls and attempted to imitate them to successful results. The following morning, a Brachiosaurus sick with a cold or a similar disease fed on the tree that the three humans were sleeping in, waking them up. Lex panicked at the sight of the dinosaur, believing it to be dangerous at first, but she soon calmed down when Dr. Alan Grant and her brother showed her that it was harmless. Dr. Grant fed the Brachiosaurus a nearby branch on the tree and Tim Murphy even pet it. However, when Lex attempted to pet the dinosaur like her brother did, the Brachiosaurus responded by sneezing on her. The humans and the Brachiosaurus later went their separate ways.\n\nIt is unknown what happened to the Brachiosaur populations on Isla Nublar after the Isla Nublar Incident of 1993.\n\nHowever, according to information revealed by InGen reports, there were at least 5 surviving Brachiosaurus on the island by October 1994. One died due to malnutrition.")

        let movieScene2 = MovieSceneModel(id: 2, movie: "Jurassic Park III", sceneDescription: "Passengers of the plane N622DC saw a herd of Brachiosaurus during their fly-over of Isla Sorna at the beginning of the Isla Sorna Incident of 2001.\n\nAnother herd was seen by Dr. Alan Grant and the Kirby family at a river bank.")
        let predator = ApexPredatorModel(id: 1, name: "Brachiosaurus", type: "land", intro: "The Brachiosaurus was a large herbivorous dinosaur that lived during the Late Jurassic period. Since the Brachiosaurus is extinct, there is no way to know for sure what its vocalizations sounded like. However, paleontologists believe that it may have made low-frequency sounds, similar to those made by modern-day elephants and whales.", movies: ["Jurassic Park","Jurassic Park III","Jurassic World: Fallen Kingdom" ], movieScenes: [movieScene1,movieScene2], link: "https://jurassicpark.fandom.com/wiki/Brachiosaurus")
        PredatorDetailsView(predator: predator)
            .preferredColorScheme(.dark)
    }
}
