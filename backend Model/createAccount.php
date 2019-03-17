<?php include "../inc/dbinfo.inc";?>
<?php

$handle = fopen('php://input','r');
$array = fgets($handle);
$arr = json_decode($array);
$first = $arr[0]->firstName;
$last = $arr[0]->lastName;
$email =  $arr[0]->customerEmail;
$pwd = $arr[0]->customerPwd;
$major = $arr[0]->major;
$ku = $arr[0]->KUID;

//check database data
$con = mysqli_connect(DB_SERVER, DB_USERNAME, DB_PASSWORD, DB_DATABASE);
if (mysqli_connect_errno()) {echo "FAILURE: fail to connect Database" . mysqli_connect_error();}
//choose a Databse
$database = mysqli_select_db($con, DB_DATABASE);

//insert cannot have same email address

$sql = "SELECT customerEmail FROM Customer WHERE customerEmail = '$email'";
$result = mysqli_query($con,$sql);
if(mysqli_num_rows($result)>0){
  echo "FAILURE: cannot have same email in table";
}else{
  //choose Customer Table
  //echo $ku;
  $ku = !empty($ku) ? $ku : 9999999;
  $ku = (int)$ku;
  //echo $ku;
  $sql = "INSERT INTO Customer (firstName,lastName,customerPwd,customerEmail,major,KUID) VALUES ('$first','$last','$pwd','$email','$major','$ku')";
  if (mysqli_query($con, $sql)) {
      echo "SUCCESS";
  } else {
      echo "FAILURE INSERT for Customer";
      //echo "FAILURE: " . $sql . "<br>" . $con->error;
  }
}

mysqli_close($con);

?>
