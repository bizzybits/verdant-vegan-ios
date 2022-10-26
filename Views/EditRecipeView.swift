//
//  EditRecipeView.swift
//  verdantVegan2
//
//  Created by Elizabeth Ponce on 10/26/22.
//

import SwiftUI

struct EditRecipeView: View {
    
    //id receiving of recipe from previous view
    @Binding var id: Int64
    
    //variables to store value from previous view
    @State var title: String = ""
    @State var cuisine: String = ""
    @State var mainIngredient: String = ""
    
    //to go back to previous view
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
         
        var body: some View {
            VStack {
                // create name field
                TextField("Enter title", text: $title)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(5)
                    .disableAutocorrection(true)
                 
                // create email field
                TextField("Enter cuisine", text: $cuisine)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(5)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                 
                // create age field, number pad
                TextField("Enter main ingredient", text: $mainIngredient)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(5)
                    .disableAutocorrection(true)
                 
                // button to update user
                Button(action: {
                    // call function to update row in sqlite database
                    DB_Manager().updateRecipe(idValue: self.id, titleValue: self.title, cuisineValue: self.cuisine, mainIngredientValue: self.mainIngredient)
     
                    // go back to home page
                    self.mode.wrappedValue.dismiss()
                }, label: {
                    Text("Edit Recipe")
                })
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.top, 10)
                    .padding(.bottom, 10)
            }.padding()
     
            // populate user's data in fields when view loaded
            .onAppear(perform: {
                 
                // get data from database
                let recipeModel: RecipeModel = DB_Manager().getRecipe(idValue: self.id)
                 
                // populate in text fields
                self.title = recipeModel.title
                self.cuisine = recipeModel.cuisine
                self.mainIngredient = recipeModel.mainIngredient
            })
        }
    }

struct EditRecipeView_Previews: PreviewProvider {
    
    //when using @Binding, do this in preview provider
    @State static var id: Int64 = 0
    
    static var previews: some View {
        EditRecipeView(id: $id)
    }
}
