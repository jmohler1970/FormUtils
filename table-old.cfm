<cfscript>

variables.Users = [ 
		{id : 1, firstName : "Joe", 		LastName : "Clinton",		Email : "j.clinton@mail.net"},
	 	{id : 2, firstName : "Jackie", 	LastName : "Bush",			Email : "j.bush@mail.net"},
		{id : 3, firstName : "John", 		LastName : "Dole", 			Email : "j.dole@mail.net"},
		{id : 4, firstName : "Jennifer", 	LastName : "Ford", 			Email : "j.ford@mail.net"},
		{id : 10, firstName : "Jerry", 	LastName : "Springfield", 	Email : "j.spring@mail.net"}
	 ];
</cfscript>


<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Hello Form Utils!</title>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bulma/0.7.1/css/bulma.min.css">
</head>
<body>
	<section class="section">
		<div class="container">

		<p>
			<a href="index.cfm" class="button is-primary">Basic Example</a>

			<a href="table.cfm" class="button is-primary">Table with Form Util</a>
		</p>

		<p>&nbsp;</p>



<cfif cgi.request_method IS "post">
	<div class="columns">
		<div class="column">
			<cfdump var="#variables.users#" label="variables.user - Original">
		</div>
		<div class="column">
			<cfdump var="#form#" label="form.user - Result">
		</div>
	</div>
</cfif>


<form name="testform" action="?" method="post">

	<table class="table">
	<thead>
		<tr>
			<th>ID</th>
			<th>First Name</th>
			<th>Last Name</th>
			<th>Email</th>
		</tr>
	</thead>
	<cfoutput>
		<cfloop array="#variables.Users#" item="user" index="i">
			<tr>
				<td><input type="number" class="input" name="user_#i#_ID" 			value="#EncodeForHTMLAttribute(User.ID)#" /></td>
				<td><input type="text"	class="input" name="user_#i#_FirstName"	value="#EncodeForHTMLAttribute(User.FirstName)#" /></td>
				<td><input type="text"	class="input" name="user_#i#_LastName" 	value="#EncodeForHTMLAttribute(User.LastName)#" /></td>
				<td><input type="email"	class="input" name="user_#i#_Email" 		value="#EncodeForHTMLAttribute(User.Email)#" /></td>
			</tr>	
		</cfloop>
	</cfoutput>
	</table>




	<button type="submit" class="button is-primary">Save data</button>
</form>

		</div>
	</section>
</body>
</html>