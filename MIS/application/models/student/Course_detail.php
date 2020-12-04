<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Course_detail extends CI_Model {

	public function __construct() {
        parent::__construct();
    }

    public function get_entry($course_id) {
    	$database = '';
        $connectionString = $this->session->userdata("connectionString");
        if(!empty($connectionString)){
            $database = SelectDB($connectionString);
        }else if(empty($connectionString)){
            $database = 'clg_db2';
        }else{
            $database = 'clg_db2';
        }
        

    	$db_query = $this->load->database($database, TRUE);
        $query = $db_query->get_where('course_details', array('id' => $course_id));
        return $query->result();
    }

}