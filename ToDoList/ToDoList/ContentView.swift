//
//  ContentView.swift
//  ToDoList
//
//  Created by StudentPM on 2/28/25.
//

import SwiftUI

struct ContentView: View {
    @State private var  newTask: String = "" //store user input
    @State private var tasks: [String] = [] //store tasks
    @State private var errorMessage: String = ""//store the error message
    
    var body: some View {
        //crate a navigation view
        NavigationView{
            VStack {//stack the thing vertically
                Text("Number of tasks: \(tasks.count)") //display the number of tasks
                    .frame(maxWidth: .infinity, alignment: .leading)//align text to the left
                    .padding()//add padding to all the text
                
                //text field to enter a new task
                TextField("Enter a new task", text: $newTask )
                    .frame(width: 340)//set the width of the text field
                    .padding(.all, 9)//add padding around the text field
                    .border(Color.gray)//add a gray border around the text field
                    .padding(.bottom, 15)//add more padding in the bottom
                
                //If there is an error message
                if !errorMessage.isEmpty{
                    Text(errorMessage)//Display the error message
                        .foregroundColor(.red)//change the color of the message to red
                }
                
                //stack buttons horizontally
                HStack{
                    //button to add a new task
                    Button(action: {
                        addTask() //call the function to add a new task
                    }, label: {
                        Text("Add Task") //the button's text
                            .frame(width: 80) //set the width of the button
                            .padding(.all, 15)//add padding around the button text
                            .foregroundColor(.white) //change the text color to white
                            .background(Color.gray) //change the background color to gray
                            .cornerRadius(5)//round the corner of the button
                    })
                    //disable the button if the task input is empty
                    .disabled(newTask.isEmpty)
                     
                    //button to remove all tasks
                    Button(action: {
                        removeAllTasks() //call the function to remove all tasks
                    }, label: {
                        Text("Remove all Tasks")//the button's text
                            .frame(width: 130)//set the width of the button
                            .padding(.all, 15)//add padding around the button text
                            .foregroundColor(.white)//change the text color to white
                            .background(Color.gray)//change the background color to gray
                            .cornerRadius(5)//round the corner of the button
                        
                    })
                    .disabled(newTask.isEmpty)//disable the button if the task input is empty
                }
                //create a list to display all tasks
                List{
                    ForEach(tasks, id: \.self){task in //like a for loop to through each task
                        Text("\(task)") //display the task text
                    }
                    .onDelete(perform: removeOneTask) //allow task deletion with swipe gesture.
                }
            }
            .navigationTitle("To Do List") //set the title for the navigation view
        }
        
        
    }
    //function for add a new task
    func addTask(){
        //if the new taks input is empty
        if newTask.isEmpty{
            errorMessage = "Task cannot be empty" //show this message
        }
        //if the new taks input is not empty
        else{
            tasks.append(newTask) //add the new task to the list
            newTask = "" //clear the text input field
            errorMessage = "" //reseat the error message
        }
    }
    
    //function for remove a single task
    func removeOneTask(at offsets: IndexSet){
        tasks.remove(atOffsets: offsets)//remove the task at the specified offset
    }
    
    //function for remove all the tasks in the list
    func removeAllTasks(){
        tasks.removeAll()//remove all the task from the list.
        newTask = "" //clear the text input field
    }
}

#Preview {
    ContentView()
}
