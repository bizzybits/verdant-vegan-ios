//
//  AddRecipeView.swift
//  verdantVegan2
//
//  Created by Elizabeth Ponce on 10/26/22.
//

import SwiftUI

struct AddRecipeView: View {
   
    //create vars to store recipe input values
    @State var title: String = ""
    @State var cuisine: String = ""
    @State var mainIngredient: String = ""
    
    //to go back on the homescreen when the recipe is added
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        
        VStack {
            //create title field
            TextField("Enter Recipe Title", text: $title)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(5)
                .disableAutocorrection(true)
            
            //create cuisine field
            TextField("Enter Cuisine", text: $cuisine)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(5)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            
            //create main ingredient field
            TextField("Enter Main Ingredient", text: $mainIngredient)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(5)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            
            //button to add a recipe
            Button(action: {
                //call function to add row in sqlite db
                DB_Manager().addRecipe(titleValue: self.title, cuisineValue: self.cuisine, mainIngredientValue: self.mainIngredient)
                //go back to home page
                self.mode.wrappedValue.dismiss()
            }, label: {
                Text("Add Recipe")
            })
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.top, 10)
                .padding(.bottom, 10)
        }
        .padding()
    }
}

struct AddRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipeView()
    }
}
