//
//  CheckListDetailViewModel.swift
//  Workade
//
//  Created by Wonhyuk Choi on 2022/10/23.
//

import UIKit
import CoreData

struct CheckListDetailViewModel {
    private let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    private var checkListViewModel = CheckListViewModel()
    
    var todos = [Todo]()
    
    var selectedCheckListIndex: Int? {
        didSet {
            loadTodos()
        }
    }

    var selectedCheckList: CheckList? {
        didSet {
            loadTodos()
        }
    }
    
    init() {
        checkListViewModel.loadCheckList()
    }
    
    private func saveTodos() {
        guard let context = context else { return }
        
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    mutating func addTodo() {
        
    }
    
    mutating func loadTodos(with request: NSFetchRequest<Todo> = Todo.fetchRequest()) {
        guard let context = context else { return }
        guard let cid = selectedCheckList?.cid else { return }
        
        let checkListPredicate = NSPredicate(format: "parentCategory.cid MATCHES %@", cid)
        
        request.predicate = checkListPredicate
        
        do {
            self.todos = try context.fetch(request)
        } catch {
            print("Error fetching data context \(error)")
        }
    }
    
    mutating func updateCheckList(title: String? = nil, emoji: String? = nil, travelDate: Date? = nil) {
        guard let seletedIndex = selectedCheckListIndex else { return }
        
        checkListViewModel.updateCheckList(at: seletedIndex, title: title, emoji: emoji, travelDate: travelDate)
    }
    
    mutating func updateTodo(at index: Int, todo: Todo) {
        
    }
    
    mutating func deleteCheckList() {
        guard let seletedIndex = selectedCheckListIndex else { return }
        guard let cid = self.checkListViewModel.checkList[seletedIndex].cid else { return }
        NotificationCenter.default.post(
            name: NSNotification.Name("deleteCheckList"),
            object: cid,
            userInfo: nil
        )
    }
    
    mutating func deleteTodo(at index: Int) {
        guard let context = context else { return }
        
        context.delete(self.todos[index])
        self.todos.remove(at: index)
        
        saveTodos()
    }
}
