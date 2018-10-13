<cfscript>

variables.User = [ 
		{id : 1, firstName : "Joe", 		LastName : "Clinton",	Email : "j.clinton@mail.net"},
	 	{id : 2, firstName : "Jackie", 	LastName : "Bush",		Email : "j.bush@mail.net"},
		{id : 3, firstName : "John", 		LastName : "Dole", 		Email : "j.dole@mail.net"},
		{id : 4, firstName : "Jennifer", 	LastName : "Ford", 		Email : "j.ford@mail.net"}
	 ];


variables.qryUser = queryNew(
	"id,firstname,lastname,email",
	"Integer,Varchar,varchar,varchar",
	variables.User
	);

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

		<p><a href="index.cfm" class="button is-primary">Basic Example</a></p>

		<p>&nbsp;</p>



<cfif cgi.request_method EQ "post">
	
	<cfset util = new FormUtils().init() />
	
	<cfset util.buildFormCollections(form) />

	<div class="columns">
		<div class="column">
			<cfdump var="#variables.user#" label="variables.user - Original">
		</div>
		<div class="column">
			<cfdump var="#form.user#" label="form.user - Result">
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
	<cfoutput query="qryUser">
		<tr>
			<td><input type="number" class="input" name="user[#currentrow#].ID" 		value="#EncodeForHTMLAttribute(ID)#" /></td>
			<td><input type="text"	class="input" name="user[#currentrow#].FirstName"	value="#EncodeForHTMLAttribute(FirstName)#" /></td>
			<td><input type="text"	class="input" name="user[#currentrow#].LastName" 	value="#EncodeForHTMLAttribute(LastName)#" /></td>
			<td><input type="email"	class="input" name="user[#currentrow#].Email" 	value="#EncodeForHTMLAttribute(Email)#" /></td>
		</tr>	
	</cfoutput>
	</table>




	<button type="submit" class="button is-primary">Load Form data</button>
</form>

		</div>
	</section>
</body>
</html>