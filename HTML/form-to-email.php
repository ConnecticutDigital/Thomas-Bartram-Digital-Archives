<?php
if(!isset($_POST['submit']))
{
	//This page should not be accessed directly. Need to submit the form.
	echo "Error! This page should not be accessed directly. You need to submit a contact form! Please visit <a href='http://www.blackrockhistory.net/contact.html'>http://www.blackrockhistory.net/contact.html</a> to submit.";
}
$name = $_POST['name'];
$visitor_email = $_POST['email'];
$reason = $_POST['reason'];
$message = $_POST['message'];
$unclearID = $_POST['textID'];
$suggest = $_POST['textWord'];
$suggestLine = $_POST['textLine'];
$prosopName = $_POST['prosopName'];
$prosopInfo = $_POST['prosopInfo'];


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
if(!empty($_POST['website'])) die();
$email_from = "bportnow@gmail.com";//<== update the email address
$email_subject = "New Form Submission";
$email_body = 
    "You have received a new inquiry from $name. \n\n".
    "User provided email:\n $visitor_email \n\n".
    
    "Inquiry type:\n $reason \n\n\n".
    "Explanation of inquiry type:\n\n".
    "\tgeneral is General Inquiry \n\n".
    "\tfunds is Funding and Donation Information \n\n".
    "\tvolunteer is Volunteer Opportunities \n\n".
    "\ttextSuggest is Suggestion for Missing or Unclear Text \n\n".
    "\tprosopSuggest is Provide Information on Person, Place, Commodity, or Organization \n\n\n".

    "The following values will be blank if not pertaining to the inquiry type:\n\n".
    "Unclear ID Number: $unclearID \n\n".
    "Suggested Word: $suggest \n\n".
    "Line containing suggest word: $suggestLine \n\n".
    "Named Entity: $prosopName \n\n".
    "Information about named entity: $prosopInfo \n\n".
    "\n\n\n".
    "Here is $name's detailed message:\n $message \n\n".
    
$to = "bportnow@gmail.com";//<== update the email address
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