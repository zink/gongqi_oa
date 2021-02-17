<?php

use Phalcon\Mvc\View;
use Phalcon\Mvc\Url as UrlResolver;
use Phalcon\Mvc\View\Engine\Volt as VoltEngine;
use Phalcon\Mvc\Model\Metadata\Memory as MetaDataAdapter;
use Phalcon\Session\Adapter\Files as SessionAdapter;
use Phalcon\Mvc\Model\Manager as ModelsManager;
use Phalcon\Flash\Session as Flash;
use Phalcon\Logger;
use Phalcon\Logger\Adapter\File as FileLogger;

use Phalcon\Events\Event;
use Phalcon\Events\Manager as EventsManager;
use Phalcon\Mvc\Dispatcher;

use Phalcon\Mvc\Collection\Manager as CollectionManager;

use Phalcon\Filter;

use Mvc\Request;
$di->set(
    'dispatcher',
    function() use ($di) {
        $evManager = $di->getShared('eventsManager');
        $evManager->attach(
            "dispatch:beforeException",
            function($event, $dispatcher, $exception)
            {
                switch ($exception->getCode()) {
                    case Dispatcher::EXCEPTION_HANDLER_NOT_FOUND:
                    case Dispatcher::EXCEPTION_ACTION_NOT_FOUND:
                        $dispatcher->forward(
                            array(
                                'controller' => 'error',
                                'action'     => 'show404',
                            )
                        );
                        return false;
                }
            }
        );
        $dispatcher = new Dispatcher();
        $dispatcher->setEventsManager($evManager);
        return $dispatcher;
    },
    true
);

/**
 * Shared configuration service
 */
$di->setShared('config', function () {
    return include APP_PATH . "/app/config/config.php";
});

/**
 * Shared loader service
 */
$di->setShared('loader', function () {
    $config = $this->getConfig();

    /**
     * Include Autoloader
     */
    include APP_PATH . '/app/config/loader.php';

    return $loader;
});

/**
 * The URL component is used to generate all kind of urls in the application
 */
$di->setShared('url', function () {
    $config = $this->getConfig();

    $url = new UrlResolver();
    $url->setBaseUri($config->application->baseUri);

    return $url;
});

/**
 * Setting up the view component
 */
$di->setShared('view', function () {
    $config = $this->getConfig();

    $view = new View();
    $view->setViewsDir($config->application->viewsDir);

    $view->registerEngines([
        '.volt' => function ($view, $di) {
            $config = $this->getConfig();

            $volt = new VoltEngine($view, $di);

            $volt->setOptions([
                'compiledPath' => $config->application->cacheDir,
                'compiledSeparator' => '_'
            ]);

            //自定义过滤器
            $compiler = $volt->getCompiler();
            $compiler->addExtension(
                new \Component\FunctionExtension()
            );

            return $volt;
        },
        '.phtml' => 'Phalcon\Mvc\View\Engine\Php'
    ]);

    return $view;
});

/**
 * Database connection is created based in the parameters defined in the configuration file
 */
$di->setShared('db', function () {
    $config = $this->getConfig();

    $dbConfig = $config->database->toArray();
    $adapter = $dbConfig['adapter'];
    unset($dbConfig['adapter']);

    $class = 'Phalcon\Db\Adapter\Pdo\\' . $adapter;
    $db = new $class($dbConfig);

    $eventsManager = new EventsManager();
    $file = $this->getConfig()->application->logDir .'debug.log';
    $logger = new FileLogger($file);

    // Listen all the database events
    $eventsManager->attach(
        "db:beforeQuery",
        function ($event, $db) use ($logger) {
            $logger->log(
                $db->getSQLStatement(),
                Logger::INFO
            );
        }
    );
    $db->setEventsManager($eventsManager);
    return $db;
});

/**
 * If the configuration specify the use of metadata adapter use it or use memory otherwise
 */
$di->setShared('modelsMetadata', function () {
    return new MetaDataAdapter();
});


/**
 * Start the session the first time some component request the session service
 */
$di->setShared('session', function () {
    $session = new SessionAdapter();
    session_save_path("/Users/zink/works/pianyijiaowo_server/tmp");
    ini_set('session.auto_start', 0);
    ini_set('session.gc_maxlifetime', 3600*24*365);
    ini_set('session.cookie_lifetime',  3600*24*365);

    if(($session_id =$_SERVER['HTTP_X_APP_SID']) || ($session_id =$this->getRequest()->get('sess_id'))){
        //for 微信小程序
        $session->setId($session_id);

    }
    $session->start();

    if($_SERVER['HTTP_X_REQUESTED_ISAPP']){
        $this->getResponse()->setHeader("Set-appstorage",'_SID='.$session->getId());
    }
    if(\Utils::is_wxapp()){
        $this->getResponse()->setHeader("Set-wxappstorage",'_SID='.$session->getId());
    }
    return $session;
});

$di->setShared('crypt', function () {
    $config = $this->getConfig();

    $crypt = new \Phalcon\Crypt();
    $crypt->setKey($config->application->cryptSalt);
    return $crypt;
});

$di->set('logger', function () {
    $file = $this->getConfig()->application->logDir . date('YmdH') . '.log';
    return new Phalcon\Logger\Adapter\File($file);
});


$di->setShared('session', function () {
    $session = new SessionAdapter();
    session_save_path("/tmp");
    ini_set('session.auto_start', 0);
    ini_set('session.gc_maxlifetime', 3600*24*365);
    ini_set('session.cookie_lifetime',  3600*24*365);

    if(($session_id =$_SERVER['HTTP_X_APP_SID']) || ($session_id =$this->getRequest()->get('sess_id'))){
        //for 微信小程序
        $session->setId($session_id);

    }
    $session->start();

    if($_SERVER['HTTP_X_REQUESTED_ISAPP']){
        $this->getResponse()->setHeader("Set-appstorage",'_SID='.$session->getId());
    }
    if(\Utils::is_wxapp()){
        $this->getResponse()->setHeader("Set-wxappstorage",'_SID='.$session->getId());
    }
    return $session;
});
/**
 * Register the session flash service with the Twitter Bootstrap classes
 */
$di->set('flash', function () {
    return new Flash([
        'error'   => 'alert alert-danger',
        'success' => 'alert alert-success',
        'notice'  => 'alert alert-info',
        'warning' => 'alert alert-warning'
    ]);
});

// 权限系统
$di->setShared('access',function (){
    return include APP_PATH .'/app/config/access.php';
});
date_default_timezone_set($di->getConfig()->datetime_zone);
