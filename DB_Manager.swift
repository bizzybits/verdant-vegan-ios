//
//  DB_Manager.swift
//  verdantVegan2
//
//  Created by Elizabeth Ponce on 10/26/22.
//

import Foundation
import SQLite

class DB_Manager {
    //sqlite instance
    private var db: Connection!
    
    //table instance
    private var recipes: Table!
    
    //columns instances of table
    private var id: Expression<Int64>!
    private var title: Expression<String>!
    private var cuisine: Expression<String>!
    private var mainIngredient: Expression<String>!
    
    //constructor of this class
    init() {
        
        //exception handling
        do {
            
            //path of document directory
            let path: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
            
            //creating database connection
            db = try Connection("\(path)/my_recipes.sqlite3")
            
            //createing table object
            recipes = Table("recipes")
            
            //create instances of each column
            id = Expression<Int64>("id")
            title = Expression<String>("title")
            cuisine = Expression<String>("cuisine")
            mainIngredient = Expression<String>("main ingredient")
            
            //check if the recipes table is already created
            if (!UserDefaults.standard.bool(forKey: "is_db_created")){
                
                //if not, then create table
                try db.run(recipes.create { (t) in
                    t.column(id, primaryKey: true)
                    t.column(title)
                    t.column(cuisine)
                    t.column(mainIngredient)
                })
                
                //set value to true so it will not attempt to create table again
                UserDefaults.standard.set(true, forKey: "is_db_created")
            }
            
        } catch {
            //show error message if any
            print(error.localizedDescription)
        }
    }
    
    public func addRecipe(titleValue: String, cuisineValue: String, mainIngredientValue: String) {
        do {
            try db.run(recipes.insert(title <- titleValue, cuisine <- cuisineValue, mainIngredient <- mainIngredientValue))
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func getRecipes() -> [RecipeModel] {
        //create empty array
        var recipeModels: [RecipeModel] = []
        
        //get all users in descending order
        recipes = recipes.order(id.desc)
        
        //exception handling
        do {
            //loop through all recipes
            for recipe in try db.prepare(recipes) {
                
                //create new model in each loop iteration
                let recipeModel: RecipeModel = RecipeModel()
                
                //set values in model from database
                recipeModel.id = recipe[id]
                recipeModel.title = recipe[title]
                recipeModel.cuisine = recipe[cuisine]
                recipeModel.mainIngredient = recipe[mainIngredient]
                
                //append in new array
                recipeModels.append(recipeModel)
            }
        } catch {
            print(error.localizedDescription)
        }
        //return array
        return recipeModels
    }
    
    //get single recipe data
    public func getRecipe(idValue: Int64) -> RecipeModel {
        //create empty object
        let recipeModel: RecipeModel = RecipeModel()
        
        //exception handling
        do {
            //get recipe using ID
            let recipe: AnySequence<Row> = try db.prepare(recipes.filter(id == idValue))
            
             
                // get row
                try recipe.forEach({ (rowValue) in
         
                    // set values in model
                    recipeModel.id = try rowValue.get(id)
                    recipeModel.title = try rowValue.get(title)
                    recipeModel.cuisine = try rowValue.get(cuisine)
                    recipeModel.mainIngredient = try rowValue.get(mainIngredient)
                })
            } catch {
                print(error.localizedDescription)
                }
         
            // return model
            return recipeModel
        }
        
    public func updateRecipe(idValue: Int64, titleValue: String, cuisineValue: String, mainIngredientValue: String) {
        do {
            //get recipe with ID
            let recipe: Table = recipes.filter(id == idValue)
            
            //run the update query
            try db.run(recipe.update(title <- titleValue, cuisine <- cuisineValue, mainIngredient <- mainIngredientValue))
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func deleteRecipe(idValue: Int64) {
        do {
            //get recipe using ID
            let recipe: Table = recipes.filter(id == idValue)
            
            //run the delete query
            try db.run(recipe.delete())
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
