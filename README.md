# ProductsAssignment

## About Project
- SwiftUI is used to create UI for screens.
- Combine is used for web service calls to fetch data from server.
- Project supports dark mode. Colors are configured for dark modes.
- This project uses Products dummy APIs (https://dummyjson.com/products).
- Project contains two screens 1) Product list screen 2) Product details screen.
- Product list screen lists the products from web service with product image, title, final price, actual price and description.
- Internet connectivity check is included which gives real time update when internet is turned off and on.
- On Product details screen, images of product with tab view pagination is displayed along with this product's title, stock details, final price, actual price and description.

## Project Architecture
- MVVM architecture is used for this project.
- SOLID principles are followed while building this project.
- As per the MVVM clean architectural pattern module has three layers:
    1) Presentation Layer:
        - View
        - ViewModel
    2) Domain Layer:
        - Model
        - Repository
        - UseCase
    3) Data Layer:
        - Repository
        - Entities
        - DataSource
- There are two more files
    1) NavigationManager: It takes care of navigation from one screen to another screen
    2) AppDIContainer: It takes care of creating objects for dependency injection.
- This project contains dedicated classes for handling actual web service call and mock web service call which adheres to single responsibility principle.
- Both APIManager and MockAPIManager need to implement APIRequestProtocol. This protocol will be used for injecting dependency in Repository class for actual or mock api call.
- For each ViewModel there is a protocol created which contains all the methods and variables which are used by View to request data from ViewModel and this protocol is implemented by ViewModel class. This gives added advantage if ViewModel has a method which should not be exposed to View but it needs to be unit tested.
- In each View, ViewModel dependency is injected in order to make View and ViewModel loosely coupled.
- As in the MVVM architecture business decisions must be implemented inside ViewModel, a closure variable is introduced for state of events in ViewModel which accepts an Enum as an argument. This gives advantage of triggering events from ViewModel whenever any business decision is taken by ViewModel and we just need to make UI change to reflect that on View.
- NetworkCheckManager class is implemented which takes care of status of internet connection. This class has a closure variable networkConnectionUpdated which updates ViewModel regarding the status of internet connection in real time so ViewModel can implement this closure and set UI accordingly.

## Test Cases
- Unit test cases for ViewModel, UseCase and Repository for both product list and product details module is included with mock data.
- Unit test case for APIManager is included for request method which is asynchronous call.
- UI test cases are included to test navigation from product list screen to product details screen and vice versa.
