var app = angular.module('venga', []);


app.controller('Destinations', function($scope, $http) {
    $scope.firstName= "John";
    $scope.lastName= "Doe";
    
    console.log('Trying to get destinations')
    $http.get('https://qc1fkjmrf5.execute-api.us-west-2.amazonaws.com/dev/destinations')
    .success(function(result) {
        console.log('success')
        console.log(result)
       $scope.destinations = result
    })
    .error(function(err) {
        console.log('There was an error')
    	console.error(err)
    })

    /*$scope.openDestination = function(id) {
        $state.go('destination', {
        	id: id
        })
 	}*/
});


app.controller('Main', function($scope, $http) {

})