Feature: Test Ryanair Users API
  Background:
  	  * def baseUrl = 'http://127.0.0.1:8900'
  	  * def user = callonce read('create_user.feature')
  	 

 Scenario: Get a user by id
    Given url baseUrl
    And path 'user'
    And param id = user.response.id
    When method get
    Then status 200
	  
	  Scenario Outline: Create a user with error
    Given url baseUrl
    And path 'user'
    And header Content-Type = 'application/json'
    And request { name: '<name>', email: '<email>' }
    When method post
    Then status 500
	  And match response == {"timestamp": "#notnull", "status": 500,"error": "Internal Server Error","message": "malformed email","path": "/user"	}
	  
	  Examples:
	  | name        | email 							|
    | Ricardo001  | mixmail.com   			|
    | Ricardo002  | tooropmixmail.com   |