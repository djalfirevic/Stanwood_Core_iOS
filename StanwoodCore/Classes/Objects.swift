//
//  Objects.swift
//  StanwoodCore
//
//  Created by Tal Zion on 03/01/2018.
//

import Foundation

extension Stanwood {
    
    /**
     Objects holds a collection of element types.
     
     >Important: only supports a single section dataType. For a more complex solution, please conform to the `DataType` protocol.
     
     #####Example: DataSource and Delegate design#####
     ````swift
     let items = [Element(id: "1"), Element(id: "2")]
     self.objects = Stanwood.Objects<Element>(items: items)
     
     self.dataSource = ElementDataSource(dataObject: objects)
     self.delegate = ElementDelegate(dataObject: objects)
     
     self.collectionView.dataSource = self.dataSource
     self.collectionView.delegate = self.delegate
     ````
     
     - SeeAlso:
     
     `AbstractCollectionDataSource`
     
     `AbstractCollectionDelegate`
     
     `AbstractTableDataSource`
     
     `AbstractTableDelegate`
     
     `DataType`
     
     `Type`
     */
    public struct Objects<T: Type>: DataType where T: Equatable {
        
        // MARK: Properties
        
        /// Items of elements<Type & Equatable>
        public var items: [T]
        
        // MARK Computet Properties
        
        /// Number of items
        public var numberOfItems: Int {
            return items.count
        }
        
        /**
         Objects only supports a single section.
         
         - Returns: current section
         
         - SeeAlso: `DataType` for multiple section option
         */
        public var numberOfSections: Int {
            return 1
        }
        
        // MARK: Initializers
        
        /**
         Initializer of Objects
         
         - Parameters:
            - items: `[T]<Type & Equatable>`
         */
        public init(items: [T]) {
            self.items = items
        }
        
        // MARK: Subsripts
        
        /**
         Subscript to get an item in row.
         
         - Parameters:
            - indexPath: IndexPath location of an item at row
         
         - Returns: `Optional<Type>`
         
         - SeeAlso: `Type`
         */
        public subscript(indexPath: IndexPath) -> Type? {
            return items[indexPath.row]
        }
        
        /**
         Subscript to get a section.
         
         >Important: `Objects` only supports a single section dataType. For a more complex solution, please conform to the `DataType` protocol.
         
         - SeeAlso: `DataType`
         */
        public subscript(section: Int) -> DataType {
            return self
        }
        
        // MARK: Public Functions
        
        /**
         Append an item or insert at index
         
         - Parameters:
            - item: <T>[Type & Equatable]
            - index: Optional<Index>
         
         - Returns: `Objects`
         */
        public func insert(item: T, at index: Int? = nil) -> Objects {
            var items = self.items
            if let index = index {
                items.insert(item, at: index)
            } else {
                items.append(item)
            }
            return Objects(items: items)
        }
        
        /**
         Move an item to index.
         
         - Parameters:
            - item: <T>[Type & Equatable]
            - index: the index to move the item
         
         - Returns: `Objects`
         */
        public func move(_ item: T, to index: Int) -> Objects {
            var items = self.items
            items.forEach({ print($0.id!) })
            if let indexToRemove = self.index(of: item) {
                items.remove(at: indexToRemove)
                items.forEach({ print($0.id!) })
                items.insert(item, at: index)
            }
            items.forEach({ print($0.id!) })
            return Objects(items: items)
        }
        
        /**
         Delete an item
         
         - Parameters:
            - item: the item to delete
         
         - Returns: `Objects`
         */
        public func delete(_ item: T) -> Objects {
            var items = self.items
            if let index = index(of: item) {
                items.remove(at: index)
            }
            return Objects(items: items)
        }
        
        /**
         Get the index of an item.
         
         - Parameters:
            - item: the item to search for in the collection
         
         - Returns: the item index
         */
        public func index(of item: T) -> Int? {
            return items.index(of: item)
        }
        
        /**
         Checking if objects contain an item.
         
         - Parameters:
            - item: the item to check it it exists.
         
         - Returns: if it exists
         */
        public func contains(_ item: T) -> Bool {
            return items.contains(item)
        }
    }
}