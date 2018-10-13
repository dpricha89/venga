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
        .state('experiences', {
            url: '/experiences/:id',
            templateUrl: 'partials/experiences.html',
            controller: 'experiences'
        })
        .state('form_experience', {
            url: '/form_experience/:id',
            templateUrl: 'partials/form_experience.html',
            controller: 'form_experience'
        })
}

angular
    .module('venga')
    .config(config)
    .run(function($rootScope, $state) {
        $rootScope.$state = $state;
    });