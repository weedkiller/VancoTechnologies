<?php defined('BASEPATH') OR exit('No direct script access allowed');?>
<?php
 if (count($_GET)>=5){
	$nri = $_GET['n']; // = 0; // 0=Not, 1=Nri
	$nri_country = $_GET['t']; // =0; // 0=not, 1=nri_developing_country, 2=nri_developed_country
	if ($_GET['r']==1) {
		$cast = 'Reserved';//0; // 0=Open, 1=Reserved
	}else{
		$cast = 'Open';//0; // 0=Open, 1=Reserved
	}
	if ($_GET['p']==2) {
		$program = 'master'; // 1=bachelor or 2=master
	}else{
		$program = 'bachelor'; // 1=bachelor or 2=master
	}
	$course_id = $_GET['s']; // = 1; // specialisation(course_id)= 1,2,3,4,5,6,7 for bachelor, specialisation(course_id)= 1,4,10,11,12 for master

	// 0=Full, 1=Half payment
	if(isset($_GET['h'])){
		$partial_payment = $_GET['h'];
	}else{
		$partial_payment = 0;
	} // 0=Full, 1=Half payment

	if ($program =='bachelor') {
		if ($nri == 1) {
			if ($nri_country == 1) {
				$fee_head_total = 20890*3;
			}elseif ($nri_country == 2) {
				$fee_head_total = 20890*5;
			}else {
				$fee_head_total = 20890;
			}
		}else{
			if ($cast == 'Open') {
				$fee_head_total = 20890;
			}else{
				$fee_head_total = 8290;
			}
		}
	}elseif ($program =='master') {
		if ($course_id == 1) {
				$fee_head_total = 83500;
		}elseif ($course_id == 4) {
			$fee_head_total = 88000;
		}elseif ($course_id == 10) {
			$fee_head_total = 49500;
		}elseif ($course_id == 11) {
			$fee_head_total = 45000;
		}elseif ($course_id == 12) {
			$fee_head_total = 44000;
		}
	}
	$pay_percentage = 0;
	$gst = 0;
	if ($partial_payment == 1) {
		$fee_head_total = $fee_head_total/2;  // 0=Full, 1=Half payment
	}

	// 0=Full, 1= cancellation payment
	if(isset($_GET['c'])){
		$cancellation_payment = $_GET['c'];
	}else{
		$cancellation_payment = 0;
	} 

	if ($cancellation_payment == 1) {
		$fee_head_total = 200000;  // 0=Full, 1=cancellation payment
		$pay_percentage = 0;
	}
}

 ?>

<div id="content-wrapper">
	<div class="<?php echo($this->session->userdata("id")) ? 'container-fluid' : 'container';?>">
		<?php if(isset($_SESSION['error'])){ ?>
		<div class="alert alert-danger alert-dismissible">
			<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
			<strong>Error!</strong> <?php echo $_SESSION['error']; ?>
		</div>
		<?php } ?>

		<?php  if (count($_GET)>=5){ ?>
			<form method="post" id="fee_pay" enctype="multipart/form-data" action="<?php echo base_url(); ?>fee_payment_post">
				<div class="card">
					<div class="card-header">
						<i class="far fa-credit-card"></i>
						Student Fees Payment				
					</div>
					<div class="card-body">
						<div class="row">
							<div class="col-md-5">
								
								<div class="form-group">
									<label for="registration_number">SVT Admission Form Number # / Application Id: <span class="required-mark">*</span></label>
									<input type="text" class="form-control" name="registration_number" id="registration_number" required>
									<span class="text-danger"><?php echo form_error('registration_number'); ?></span>
								</div>
							</div>
						</div>		
						<div class="row align-items-center">
							<div class="col-md-5">
								<div class="form-group">
									<label for="first_name">First Name: <span class="required-mark">*</span></label>
									<input type="text" class="form-control" name="first_name" id="first_name" required>
									<span class="text-danger"><?php echo form_error('first_name'); ?></span>
								</div>
							</div>
							<div class="col-md-5">
								<div class="form-group">
									<label for="last_name">Last Name: <span class="required-mark">*</span></label>
									<input type="text" class="form-control" name="last_name" id="last_name" required>
									<span class="text-danger"><?php echo form_error('last_name'); ?></span>
								</div>
							</div>
						</div>
						<div class="row align-items-center">
							<div class="col-md-5">	
								<div class="form-group">
									<label for="email">Email Address: <span class="required-mark">*</span></label>
									<input type="email" class="form-control" name="email" id="email" required>
									<span class="text-danger"><?php echo form_error('email'); ?></span>
								</div>
							</div>
							<div class="col-md-5">
								<div class="form-group">
									<label for="phone_number">Mobile: <span class="required-mark">*</span></label>
									<input type="text" class="form-control" name="phone_number" minlength="10" maxlength="10" id="phone_number" required>
									<span class="text-danger"><?php echo form_error('phone_number'); ?></span>
								</div>
							</div>						
						</div>
						 
					<table class="table">
						<tbody class="aliceblue">
							<tr>
								<th>Fee Head Total</th>
								<th>??? <?php echo number_format($fee_head_total,2); ?></th>
							</tr>
							<tr>
								<td>Online Payment Processing Charge</td>
								<td>??? <?php
								 		//$pay_percentage = ($fee_head_total/100) * 2;
										echo number_format($pay_percentage+$gst, 2); ?>
							</td>
							</tr>
							<!-- <tr>
								<td>GST (18%)</td>
								<td>??? <?php // $gst = (18/100)*($pay_percentage);
								//echo number_format($gst, '2');?>
							</td>
							</tr> -->
							<tr>
								<th>Grand Total</th>
								<th>??? <?php $grand_total = $fee_head_total+$pay_percentage+$gst;
											echo number_format($grand_total, '2').'/-'; 
										?>
							</th>
							</tr>
						</tbody>
					</table>
					<input type="hidden" id="fee_head_total" name="fee_head_total" value="<?php echo $fee_head_total; ?>" required>
			        <input type="hidden" id="total_amount" name="amount" value="<?php echo number_format($grand_total, '2'); ?>" required>
			        <input type="hidden" name="caste" value="<?php echo $cast; ?>" required>
			        <input type="hidden" name="course_id" value="<?php echo $course_id; ?>" required>
			        <input type="hidden" name="program" value="<?php echo $program; ?>" required>
			        <input type="hidden" name="cancellation_payment" value="<?php echo $cancellation_payment; ?>" required>
			        <input type="hidden" id="online_amount" name="commission" value="<?php echo number_format($pay_percentage+$gst, '2'); ?>" required>
					<div class="row align-items-end">
						<div class="col-md-4">
							<div class="form-group">
								<button type="submit" class="btn btn-success">Make Payment</button>
							</div>
						</div>
					</div>
					</div>						
				</div>
			</form>
		<?php } else { ?>
           <div style="height: 600px">
	           <div class="card">
				<div class="card-header">
					<i class="far fa-credit-card"></i>
					Student Fees Payment				
				</div>
				<div class="card-body">
					Incorrect values, Please use correct link to pay fees....
				</div>						
			</div>
			</div> <!-- echo "Incorrect Standard, Please use correct link to register...."; -->
          <?php } ?>
        </div>
	</div>
</div>