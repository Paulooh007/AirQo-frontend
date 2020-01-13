<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Airqo extends CI_Controller
{

	// Log page visits
	public function logVisitedPage($page)
	{
		$user_agent_data 		= $this->getBrowsingData();

		$data 				= array(
			'ss_page'       		=>  $page,
			'ss_ipAddress'  		=>  $_SERVER["REMOTE_ADDR"],
			'ss_userAgent'  		=>  $user_agent_data['userAgent'],
			'ss_browser'  			=>  $user_agent_data['name'],
			'ss_browserVersion'		=>  $user_agent_data['version'],
			'ss_osType'      		=>  $user_agent_data['platform'],
			'ss_deviceType'   		=>  $user_agent_data['device'],
			'ss_date'   		  	=>  date('Y-m-d')
		);

		$this->AirqoModel->add_page_visits($data);
	}

	public function index()
	{
		$data['title'] = 'HOME';
		$data['contact'] = $this->AirqoModel->get_contact_details();
		// $data['projectFirst'] = $this->AirqoModel->get_project_first();
		// $data['projectSecond'] = $this->AirqoModel->get_project_next4();

		$this->logVisitedPage($data['title']);
		$this->load->view('lib/header', $data);
		$this->load->view('ft-home', $data);
		$this->load->view('lib/footer');
	}

	public function projects()
	{
		$data['title'] = 'PROJECTS';
		$data['projects'] = $this->AirqoModel->get_project_details();
		$data['contact'] = $this->AirqoModel->get_contact_details();
		$this->logVisitedPage($data['title']);

		$this->load->view('lib/header', $data);
		$this->load->view('airqo-projects', $data);
		$this->load->view('lib/footer');
	}

	public function projectDetails($slug)
	{
		$data['projects'] = $this->AirqoModel->get_project_details($slug);
		$data['contact'] = $this->AirqoModel->get_contact_details();
		$data['title'] = 'Project Details';
		// $data['title'] = $data['projects']['p_title'];
		$this->logVisitedPage($data['title']);

		$this->load->view('lib/header', $data);
		$this->load->view('airqo-projects-details', $data);
		$this->load->view('lib/footer');
	}
	public function about()
	{
		$data['title'] = 'About';
		$data['contact'] = $this->AirqoModel->get_contact_details();
		$data['about'] = $this->AirqoModel->get_about_details();
		$this->logVisitedPage($data['title']);

		$this->load->view('lib/header', $data);
		$this->load->view('airqo-about', $data);
		$this->load->view('lib/footer');
	}
	public function howItWorks()
	{
		$data['title'] = 'How It Works';
		$data['contact'] = $this->AirqoModel->get_contact_details();
		$data['how'] = $this->AirqoModel->get_HowItWorks_details();
		$this->logVisitedPage($data['title']);

		$this->load->view('lib/header', $data);
		$this->load->view('airqo-how-it-works', $data);
		$this->load->view('lib/footer');
	}
	public function team()
	{
		$data['title'] = 'Team';
		$data['contact'] = $this->AirqoModel->get_contact_details();
		$data['team'] = $this->AirqoModel->get_team_details();
		$this->logVisitedPage($data['title']);

		$this->load->view('lib/header', $data);
		$this->load->view('airqo-team', $data);
		$this->load->view('lib/footer');
	}
	public function news()
	{
		$data['title'] = 'News';
		$data['contact'] = $this->AirqoModel->get_contact_details();
		$data['news'] = $this->AirqoModel->get_news_details();
		$this->logVisitedPage($data['title']);

		$this->load->view('lib/header', $data);
		$this->load->view('airqo-news', $data);
		$this->load->view('lib/footer');
	}
	public function newsDetails($slug)
	{
		$data['contact'] = $this->AirqoModel->get_contact_details();
		$data['news'] = $this->AirqoModel->get_news_details($slug);
		$data['title'] = 'News Details';
		// $data['title'] = $data['news']['news_title'];
		$this->logVisitedPage($data['title']);

		$this->load->view('lib/header', $data);
		$this->load->view('airqo-news-details', $data);
		$this->load->view('lib/footer');
	}
	public function appNode($id)
	{
		$data['contact'] = $this->AirqoModel->get_contact_details();
		$data['node'] = $this->AirqoModel->get_app_node_details($id);
		$data['title'] = $data['node']['an_name'];
		$this->logVisitedPage($data['title']);

		$this->load->view('lib/header', $data);
		$this->load->view('airqo-app-node', $data);
		$this->load->view('lib/footer');
	}
	public function faqs()
	{
		$data['title'] = 'FAQs';
		$data['contact'] = $this->AirqoModel->get_contact_details();
		$data['faqs'] = $this->AirqoModel->get_faqs();
		$this->logVisitedPage($data['title']);

		$this->load->view('lib/header', $data);
		$this->load->view('airqo-faqs', $data);
		$this->load->view('lib/footer');
	}
	public function visitorEmail()
	{
		$this->form_validation->set_rules('email', 'email address', 'required|trim|valid_email');

		if ($this->form_validation->run() === false) {
			$data['contact'] = $this->AirqoModel->get_contact_details();
			redirect('Airqo/index');
		} else {
			$data                       = array(
				'sub_email'       => $this->input->post('email'),
				'sub_date'       => date('Y-m-d h:i:s')
			);

			$send = $this->AirqoModel->add_user_data($data);
			if ($send) {
				$this->session->set_flashdata("msg", "You have subscribed to our newsletter successfully, we shall keep you updated");
				redirect('home');
			} else {
				$this->session->set_flashdata("error", "Oops...Something went wrong, Please try again!");
				redirect('home');
			}
		}
	}

	// Get User Browsing Info
	public function getBrowsingData()
	{
		$u_agent 			= $_SERVER['HTTP_USER_AGENT'];
		$bname 				= 'Unknown';
		$platform 		= 'Unknown';
		$version			= "Unknown";
		$matches = array();
		// First get the platform
		if (preg_match('/linux/i', $u_agent)) {
			$platform = 'Linux';
		} elseif (preg_match('/macintosh|mac os x/i', $u_agent)) {
			$platform = 'Mac';
		} elseif (preg_match('/windows|win32/i', $u_agent)) {
			$platform = 'Windows';
		}

		// Next get the name of the useragent yes seperately and for good reason
		if (preg_match('/MSIE/i', $u_agent) && !preg_match('/Opera/i', $u_agent)) {
			$bname 	= 'Internet Explorer';
			$ub 		= "MSIE";
		} elseif (preg_match('/Firefox/i', $u_agent)) {
			$bname 	= 'Mozilla Firefox';
			$ub 		= "Firefox";
		} elseif (preg_match('/Chrome/i', $u_agent)) {
			$bname 	= 'Google Chrome';
			$ub 		= "Chrome";
		} elseif (preg_match('/Safari/i', $u_agent)) {
			$bname 	= 'Apple Safari';
			$ub 		= "Safari";
		} elseif (preg_match('/Opera/i', $u_agent)) {
			$bname 	= 'Opera';
			$ub 		= "Opera";
		} elseif (preg_match('/Netscape/i', $u_agent)) {
			$bname 	= 'Netscape';
			$ub 		= "Netscape";
		}

		// Finally get the correct version number
		$known 			= array('Version', $ub, 'other');
		$pattern 		= '#(?<browser>' . join('|', $known) . ')[/ ]+(?<version>[0-9.|a-zA-Z.]*)#';
		if (!preg_match_all($pattern, $u_agent, $matches)) {
			// we have no matching number just continue
		}

		// See how many we have
		$i = count($matches['browser']);
		if ($i != 1) {
			// We will have two since we are not using 'other' argument yet
			// See if version is before or after the name
			if (strripos($u_agent, "Version") < strripos($u_agent, $ub)) {
				$version  = $matches['version'][0];
			} else {
				$version  = $matches['version'][1];
			}
		} else {
			$version    = $matches['version'][0];
		}

		// Check if we have a number
		if ($version == null || $version == "") {
			$version = "?";
		}

		// Is the device a mobile device or desktop device
		$device 		= "Mobile";

		$iPod 			= stripos($u_agent, "iPod");
		$iPad 			= stripos($u_agent, "iPad");
		$iPhone 		= stripos($u_agent, "iPhone");
		$Android 		= stripos($u_agent, "Android");
		$iOS 				= stripos($u_agent, "iOS");
		$Blackberry = stripos($u_agent, "Blackberry");
		$Edge       = stripos($u_agent, "Edge");
		$IEMobile 	= stripos($u_agent, "Internet Explorer");
		$OperaMini 	= stripos($u_agent, "Opera");
		$webOS 			= stripos($u_agent, "webOS");

		if (($iPod || $iPad || $iPhone || $Android || $iOS || $webOS || $Blackberry || $Edge || $IEMobile || $OperaMini) != true) {
			$device = "Desktop";
		}

		return array(
			'userAgent' => $u_agent,
			'name'      => $bname,
			'version'   => $version,
			'platform'  => $platform,
			'device'  	=> $device,
			'pattern'   => $pattern
		);
	}
	public  function thetime()
	{
		// new Date("2014-07-09T12:30:41Z").getTime();
		// 	$date = new DateTime("2014-07-09T12:30:41Z");
		// 	// echo time();
		// 	// echo $date;
		// 	$date = DateTime::createFromFormat('j-M-Y', '15-Feb-2009');
		// echo $date->format('Y-m-d');
		echo strtotime("2014-07-09T12:30:41Z");
	}
	public function Map()
	{
		$data['title'] 	= 'Map';
		$data['contact'] 	= $this->AirqoModel->get_contact_details();
		// $data['faqs'] 		= $this->AirqoModel->get_faqs();
		$this->logVisitedPage($data['title']);

		$this->load->view('lib/header', $data);
		$this->load->view('airqo-map', $data);
		// $this->load->view('lib/footer');
	}

	public function NodeSearch()
	{
		$response = array();

		$this->form_validation->set_rules('searchkey', 'SearchKey', 'trim|required|xss_clean');
		
		if ($this->form_validation->run() == FALSE) {
			$response['success'] = 0;
			$response['message'] = 'Missing Parameter(s)';
			
			echo json_encode($response);
		} else {
			$key = $this->input->post('searchkey');
			$query_search = $this->db->query("SELECT * FROM tbl_app_nodes WHERE an_name LIKE '%$key%' OR an_map_address LIKE '%$key%'");
			if($query_search->num_rows() > 0) {
				$results = $query_search->result_array();
				$search_result = '';
				foreach ($results as $row) {
					$search_result .= '
						<a href="'.site_url('node/' . $row['an_channel_id']).'" class="list-group-item list-group-item-action flex-column align-items-start" style="border-radius: 0px;">
							<div class="row">
								<div class="col-md-12">
									<div class="col-md-1 text-center" style="padding: 1em;">
										<i class="fa fa-thumb-tack fa-3x" style="transform: rotate(45deg);"></i>
									</div>
									<div class="col-md-11">
										<div class="d-flex justify-content-between">
											<h4 class="mb-1">'.$row['an_name'].'</h4>
										</div>
										<p class="mb-1">'.$row['an_map_address'].'</p>
									</div>
								</div>
							</div>
						</a>
					';
				}
				$response['searchresults'] = $search_result;
				$response['success'] = 1;
				$response['message'] = 'Results';
				
				echo json_encode($response);
			} else{
				$response['success'] = 0;
				$response['message'] = 'No Results';
				
				echo json_encode($response);
			}
		}
		
	}
}