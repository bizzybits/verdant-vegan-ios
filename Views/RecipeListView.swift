//
//  RecipeListView.swift
//  verdantVegan2
//
//  Created by Elizabeth Ponce on 10/26/22.
//


import SwiftUI

struct RecipeListView: View {
    
    //array of recipe models
    @State var recipeModels: [RecipeModel] = []
    
    //check if recipe is selected for edit
    @State var recipeSelected: Bool = false
    
    //id of selected recipe to edit or delete
    @State var selectedRecipeID: Int64 = 0
    
    
    var body: some View {
        NavigationView {
            VStack {
                // create link to add user
                Spacer()
                NavigationLink (destination: AddRecipeView(), label: {
                    Text("Add Recipe")
                })
                HStack {
                    // navigation link to go to edit recipe view
                    NavigationLink (destination: EditRecipeView(id: self.$selectedRecipeID), isActive: self.$recipeSelected) {
                        EmptyView()
                    }
                    // create list view to show all users
                    List (self.recipeModels) { (model) in
                     
                        // show name, email and age horizontally
                        HStack {
                            Text(model.title)
                            Spacer()
                            Text(model.cuisine)
                            Spacer()
                            Text(model.mainIngredient)
                            Spacer()
                        }
                            // edit button goes here
                        HStack{
                            Button(action: {
                                self.selectedRecipeID =  model.id
                                self.recipeSelected = true
                            }, label: {
                                Text("Edit")
                                    .foregroundColor(Color.blue)
                                    .frame(width: 200, alignment: .leading)
                                    .multilineTextAlignment(.leading)
                            })
                            //by default buttons are full width
                            //to prevent this use the following
                            .buttonStyle(PlainButtonStyle())
                            
                            //delete button here
                            // button to delete user
                            Button(action: {
                     
                                // create db manager instance
                                let dbManager: DB_Manager = DB_Manager()
                     
                                // call delete function
                                dbManager.deleteRecipe(idValue: model.id)
                     
                                // refresh the user models array
                                self.recipeModels = dbManager.getRecipes()
                            }, label: {
                                Text("Delete")
                                    .foregroundColor(Color.red)
    
                            })// by default, buttons are full width.
                            // to prevent this, use the following
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }

            }
            // load data in recipe models array
            .onAppear(perform: {
                self.recipeModels = DB_Manager().getRecipes()
            })
            .padding()
            .navigationBarTitle("SQLite")
        
       
        }
    }
}

struct RecipeListView_Previews: PreviewProvider {
    
    static var previews: some View {
        RecipeListView()
        
    }
}
