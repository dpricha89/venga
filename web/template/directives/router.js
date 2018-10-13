function config($stateProvider, $urlRouterProvider) {
    //$urlRouterProvider.otherwise('/login');

    $stateProvider
        .state('login', {
            url: '/login',
            templateUrl: 'views/login.html',
            controller: 'loginController'
        })
        .state('index', {
            abstract: true,
            url: '/index',
            templateUrl: 'index.html',
        })
        .state('destinations', {
            url: '/destinations/:id',
            templateUrl: 'partials/destinations.html',
            controller: 'destinations'
        })
}

angular
    .module('venga')
    .config(config)
    .run(function($rootScope, $state) {
        $rootScope.$state = $state;
    });