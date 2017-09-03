<?php
if(!isset($_POST['submit']))
{
	//This page should not be accessed directly. Need to submit the form.
	echo "Error! This page should not be accessed directly. You need to submit a contact form! Please visit <a href='http://www.blackrockhistory.net/contact.html'>http://www.blackrockhistory.net/contact.html</a> to submit.";
}
$name = $_POST['name'];
$visitor_email = $_POST['email'];
//$reason = $_POST[''];
$message = $_POST['message'];


//Validate first
if(empty($name)||empty($visitor_email)) 
{
    echo "Error! Name and email are mandatory on contact form. Please return to <a href='http://www.blackrockhistory.net/contact.html'>http://www.blackrockhistory.net/contact.html</a> to complete your inquiry.";
    exit;
}
if(empty($message))
{
    echo "Error! A message is mandatory. Please provide a detailed message regarding your inquiry so we can better serve you. Return to <a href='http://www.blackrockhistory.net/contact.html'>http://www.blackrockhistory.net/contact.html</a> to complete your inquiry.";
    exit;
}

if(IsInjected($visitor_email))
{
    echo "Error! You have provided an invalid email value. Return to <a href='http://www.blackrockhistory.net/contact.html'>http://www.blackrockhistory.net/contact.html</a> to complete your inquiry.";
    exit;
}

$email_from = "rjp396@gmail.com";//<== update the email address
$email_subject = "New Form Submission";
$email_body = 
    "You have received a new inquiry from $name. \n\n".
    "User provided email:\n $visitor_email \n\n".
    //"Inquiry type:\n $reason \n\n".
    "Here is their detailed message:\n $message \n\n".
    
$to = "rjp396@gmail.com";//<== update the email address
$headers = "From: $email_from \r\n";
$headers .= "Reply-To: $visitor_email \r\n";
//Send the email!
mail($to,$email_subject,$email_body);
//done. redirect to thank-you page.

header('Location: http://blackrockhistory.net/thanks.html');

// Function to validate against any email injection attempts
function IsInjected($str)
{
  $injections = array('(\n+)',
              '(\r+)',
              '(\t+)',
              '(%0A+)',
              '(%0D+)',
              '(%08+)',
              '(%09+)'
              );
  $inject = join('|', $injections);
  $inject = "/$inject/i";
  if(preg_match($inject,$str))
    {
    return true;
  }
  else
    {
    return false;
  }
}
   
?> 