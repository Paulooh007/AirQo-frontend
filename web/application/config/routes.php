<?php
defined('BASEPATH') OR exit('No direct script access allowed');


$route['default_controller'] = 'Airqo';
$route['404_override'] = '';
$route['translate_uri_dashes'] = FALSE;

$route['home']         = 'airqo/index';
$route['about']        = 'airqo/about';
$route['how-it-works'] = 'airqo/howitworks';
$route['team']         = 'airqo/team';
$route['news']         = 'airqo/news';
$route['faqs']         = 'airqo/faqs';
$route['amap']          = 'airqo/map';
$route['node/(:any)']  = 'airqo/appnode/$1';
$route['news/(:any)']  = 'airqo/newsdetails/$1';
$route['node-search']     = 'airqo/nodesearch';
$route['projects']     = 'airqo/projects';
$route['project/(:any)']     = 'airqo/projectdetails/$1';



/**
 * Admin Routes
 */

$route['a-user-places'] = 'User/UserPlaces';
$route['a-load-userplaces-table'] = 'User/LoadUserPlacesTable';

$route['a-report-subscription'] = 'User/ReportSubscription';
$route['a-load-report-subscriptions-table'] = 'User/LoadReportSubscriptionTable';

$route['a-threshold-alerts'] = 'User/ThresholdAlertSubscriptions';
$route['a-load-threshold-subscriptions-table'] = 'User/LoadThresholdSubscriptionTable';

$route['a-get-involved'] = 'User/GetInvolved';
$route['a-load-question'] = 'User/LoadGetinvloved';
$route['a-create-question'] = 'User/CreateQuestion';
$route['a-edit-question'] = 'User/EditQuestion';
$route['a-delete-question'] = 'User/DeleteQuestion';
$route['a-disable-question'] = 'User/DisableQuestion';
$route['a-activate-question'] = 'User/ActivateQuestion';
$route['a-load-questions-table'] = 'User/LoadGetInvolvedTable';

$route['a-feedback'] = 'User/AppFeedback';
$route['a-load-feedback-table'] = 'User/LoadFeedbackTable';

$route['a-aqi-camera'] = 'User/AQICamera';
$route['a-load-aqi-camera-table'] = 'User/LoadAQICameraTable';
$route['a-aqi-approve'] = 'User/ApproveAqi';
$route['a-aqi-decline'] = 'User/DeclineAqi';

$route['a-login'] = 'Admin/login';
$route['a-dashboard'] = 'Admin/dashboard';
$route['a-administrators'] = 'Admin/administrators';
$route['a-check-mail'] = 'Admin/checkEmail';
$route['a-send-forgot-password-email'] = 'Admin/sendForgotPasswordEmail';

